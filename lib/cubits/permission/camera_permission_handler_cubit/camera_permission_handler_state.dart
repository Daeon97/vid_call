// ignore_for_file: public_member_api_docs

part of 'camera_permission_handler_cubit.dart';

abstract final class CameraPermissionHandlerState extends Equatable {
  const CameraPermissionHandlerState();
}

final class CameraPermissionHandlerInitialState
    extends CameraPermissionHandlerState {
  const CameraPermissionHandlerInitialState();

  @override
  List<Object?> get props => [];
}

final class GettingCameraPermissionState extends CameraPermissionHandlerState {
  const GettingCameraPermissionState();

  @override
  List<Object?> get props => [];
}

final class CameraPermissionGrantedState extends CameraPermissionHandlerState {
  const CameraPermissionGrantedState();

  @override
  List<Object?> get props => [];
}

final class CameraPermissionNotGrantedState
    extends CameraPermissionHandlerState {
  const CameraPermissionNotGrantedState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}

final class CameraPermissionPermanentlyDeniedState
    extends CameraPermissionHandlerState {
  const CameraPermissionPermanentlyDeniedState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
