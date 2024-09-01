import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_manage/mobile_devices/logic/mobile_list/mobile_list_cubit.dart';
import 'package:form_manage/mobile_devices/widgets/mobile_devices_list_widget.dart';

class MobileDevicesListScreen extends StatelessWidget {
  const MobileDevicesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MobileListCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mobile Devices'),
          actions: [
            //Add button
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
            ),
          ],
        ),
        body: const MobileDevicesList(),
      ),
    );
  }
}
