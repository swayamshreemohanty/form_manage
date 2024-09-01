part of 'manage_mobile_device_cubit.dart';

sealed class ManageMobileDeviceState {}

final class ManageMobileDeviceInitial extends ManageMobileDeviceState {}

final class ManageMobileDeviceRequestLoading extends ManageMobileDeviceState {}

final class ManageMobileDeviceRequestSuccess extends ManageMobileDeviceState {
  final String message;
  final MobileDeviceModel mobileDevice;

  ManageMobileDeviceRequestSuccess(this.message, this.mobileDevice);
}

final class ManageMobileDeviceRequestError extends ManageMobileDeviceState {
  final String message;
  ManageMobileDeviceRequestError(this.message);
}
