import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_manage/mobile_devices/logic/mobile_list/mobile_list_cubit.dart';
import 'package:form_manage/mobile_devices/models/mobile_device_model.dart';
import 'package:form_manage/mobile_devices/screens/mobile_device_screen.dart';

class MobileDevicesList extends StatelessWidget {
  const MobileDevicesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MobileListCubit, MobileListState>(
      builder: (context, state) {
        if (state is MobileListLoading || state is MobileListInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MobileListLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: state.mobileDevices.length,
            itemBuilder: (context, index) {
              final mobileDevice = state.mobileDevices[index];
              return MobileDeviceWidget(mobileDevice: mobileDevice);
            },
          );
        } else {
          return const Center(
            child: Text('Something went wrong!'),
          );
        }
      },
    );
  }
}

class MobileDeviceWidget extends StatelessWidget {
  const MobileDeviceWidget({
    super.key,
    required this.mobileDevice,
  });

  final MobileDeviceModel mobileDevice;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(8),
      key: ValueKey(mobileDevice.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(mobileDevice.name, style: const TextStyle(fontSize: 18)),
          Text(mobileDevice.imei),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Edit button
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  //Navigate to the MobileDeviceScreen
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => MobileDeviceScreen(
                        existingMobileDevice: mobileDevice,
                      ),
                    ),
                  )
                      .then((result) {
                    if (result != null && context.mounted) {
                      context
                          .read<MobileListCubit>()
                          .insertOrUpdateMobileDevice(result);
                    }
                  });
                },
              ),

              //Delete button
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  if (mobileDevice.id != null) {
                    context
                        .read<MobileListCubit>()
                        .deleteMobileDevice(mobileDevice.id!);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
