import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_manage/mobile_devices/logic/mobile_list/mobile_list_cubit.dart';
import 'package:form_manage/mobile_devices/models/mobile_device_model.dart';
import 'package:form_manage/mobile_devices/screens/mobile_device_screen.dart';
import 'package:form_manage/mobile_devices/widgets/mobile_devices_list_widget.dart';

class MobileDevicesListScreen extends StatelessWidget {
  const MobileDevicesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MobileListCubit()..loadMobileDevices(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Mobile Devices'),
              actions: [
                //Add button
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    //Navigate to the MobileDeviceScreen
                    Navigator.of(context)
                        .push<MobileDeviceModel>(MaterialPageRoute(
                            builder: (context) => const MobileDeviceScreen()))
                        .then((result) {
                      if (result != null && context.mounted) {
                        context
                            .read<MobileListCubit>()
                            .insertOrUpdateMobileDevice(result);
                      }
                    });
                  },
                ),
              ],
            ),
            body: const MobileDevicesList(),
          );
        }
      ),
    );
  }
}
