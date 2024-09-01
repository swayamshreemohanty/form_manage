import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_manage/mobile_devices/models/mobile_device_model.dart';

part 'mobile_list_state.dart';

class MobileListCubit extends Cubit<MobileListState> {
  MobileListCubit() : super(MobileListInitial());

  void loadMobileDevices() {
    emit(MobileListLoading());
    // Simulate a network request
    Future.delayed(const Duration(seconds: 2), () {
      emit(
        MobileListLoaded(
          [
            MobileDeviceModel(
              id: "1",
              name: 'iPhone 13',
              imei: '123456789012345',
            ),
            MobileDeviceModel(
              id: "2",
              name: 'Galaxy S21',
              imei: '987654321098765',
            ),
          ],
        ),
      );
    });
  }

  void deleteMobileDevice(String id) {
    final currentState = state;
    if (currentState is MobileListLoaded) {
      final mobileDevices = currentState.mobileDevices;
      final updatedMobileDevices = List<MobileDeviceModel>.from(mobileDevices)
        ..removeWhere((mobileDevice) => mobileDevice.id == id);
      emit(MobileListLoaded(updatedMobileDevices));
    }
  }

  //insert mobile device
  void insertOrUpdateMobileDevice(MobileDeviceModel mobileDevice) {
    final currentState = state;
    if (currentState is MobileListLoaded) {
      final mobileDevices = currentState.mobileDevices;

      //check if the mobile device already exists, if it does, update it, else add it
      for (var i = 0; i < mobileDevices.length; i++) {
        if (mobileDevices[i].id == mobileDevice.id) {
          mobileDevices[i] = mobileDevice;
          emit(MobileListLoaded(mobileDevices));
          return;
        }
      }

      //add the mobile device
      mobileDevices.add(mobileDevice);

      emit(MobileListLoaded(mobileDevices));
      return;
    }
  }
}
