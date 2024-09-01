part of 'mobile_list_cubit.dart';

sealed class MobileListState {}

final class MobileListInitial extends MobileListState {}

final class MobileListLoading extends MobileListState {}

final class MobileListLoaded extends MobileListState {
  final List<MobileDeviceModel> mobileDevices;
  MobileListLoaded(this.mobileDevices);
}

final class MobileListError extends MobileListState {
  final String message;

  MobileListError(this.message);
}
