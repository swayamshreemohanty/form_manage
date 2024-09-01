import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_manage/mobile_devices/logic/manage_mobile_device/manage_mobile_device_cubit.dart';
import 'package:form_manage/mobile_devices/models/mobile_device_model.dart';
import 'package:uuid/uuid.dart';

class MobileDeviceScreen extends StatefulWidget {
  final MobileDeviceModel? existingMobileDevice;
  const MobileDeviceScreen({super.key, this.existingMobileDevice});

  @override
  State<MobileDeviceScreen> createState() => _MobileDeviceScreenState();
}

class _MobileDeviceScreenState extends State<MobileDeviceScreen> {
  late bool isEditMode = widget.existingMobileDevice != null;

  //form key
  final _formKey = GlobalKey<FormState>();

  //name controller
  final _nameController = TextEditingController();

  //imei controller
  final _imeiController = TextEditingController();

  void preFillForm() {
    if (isEditMode) {
      _nameController.text = widget.existingMobileDevice!.name;
      _imeiController.text = widget.existingMobileDevice!.imei;
    }
  }

  @override
  void initState() {
    super.initState();
    preFillForm();
  }

  //dispose controllers
  @override
  void dispose() {
    _nameController.dispose();
    _imeiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageMobileDeviceCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mobile Device'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                //name text field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                //imei text field
                TextFormField(
                  controller: _imeiController,
                  decoration: const InputDecoration(labelText: 'IMEI'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an IMEI';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                //save button
                BlocConsumer<ManageMobileDeviceCubit, ManageMobileDeviceState>(
                  listener: (context, manageMobileDeviceState) {
                    if (manageMobileDeviceState
                        is ManageMobileDeviceRequestSuccess) {
                      //show snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(manageMobileDeviceState.message),
                        ),
                      );

                      Navigator.of(context)
                          .pop(manageMobileDeviceState.mobileDevice);
                    }
                  },
                  builder: (context, manageMobileDeviceState) {
                    return ElevatedButton(
                      onPressed: manageMobileDeviceState
                              is ManageMobileDeviceRequestLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                //close the keyboard
                                FocusScope.of(context).unfocus();

                                //create instance of MobileDeviceModel
                                final mobileDevice = MobileDeviceModel(
                                  id: const Uuid().v4(),
                                  name: _nameController.text,
                                  imei: _imeiController.text,
                                );

                                context
                                    .read<ManageMobileDeviceCubit>()
                                    .manageMobileDevice(
                                      mobileDevice,
                                      isEdit: isEditMode,
                                    );
                              }
                            },
                      child: manageMobileDeviceState
                              is ManageMobileDeviceRequestLoading
                          ? const CircularProgressIndicator()
                          : Text(isEditMode ? 'Update' : 'Save'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
