import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_manage/mobile_devices/models/mobile_device_model.dart';

part 'manage_mobile_device_state.dart';

class ManageMobileDeviceCubit extends Cubit<ManageMobileDeviceState> {
  ManageMobileDeviceCubit() : super(ManageMobileDeviceInitial());

  void manageMobileDevice(
    MobileDeviceModel mobileDevice, {
    bool isEdit = false,
  }) {
    emit(ManageMobileDeviceRequestLoading());
    // Simulate a network request
    Future.delayed(const Duration(seconds: 2), () {
      emit(ManageMobileDeviceRequestSuccess(
        isEdit ? 'Device updated' : 'Device added',
      ));
    });
  }
}
