import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_manage/mobile_devices/logic/mobile_list/mobile_list_cubit.dart';
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
            itemCount: state.mobileDevices.length,
            itemBuilder: (context, index) {
              final mobileDevice = state.mobileDevices[index];
              return ListTile(
                key: ValueKey(mobileDevice.id),
                title: Text(mobileDevice.name),
                subtitle: Text(mobileDevice.imei),
                trailing: Row(
                  children: [
                    //Edit button
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        //Navigate to the MobileDeviceScreen
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MobileDeviceScreen()));
                      },
                    ),

                    //Delete button
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context
                            .read<MobileListCubit>()
                            .deleteMobileDevice(index);
                      },
                    ),
                  ],
                ),
              );
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
