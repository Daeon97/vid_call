// ignore_for_file: public_member_api_docs

part of 'microphone_permission_handler_cubit.dart';

abstract final class MicrophonePermissionHandlerState extends Equatable {
  const MicrophonePermissionHandlerState();
}

final class MicrophonePermissionHandlerInitialState
    extends MicrophonePermissionHandlerState {
  const MicrophonePermissionHandlerInitialState();

  @override
  List<Object?> get props => [];
}

final class GettingMicrophonePermissionState
    extends MicrophonePermissionHandlerState {
  const GettingMicrophonePermissionState();

  @override
  List<Object?> get props => [];
}

final class MicrophonePermissionGrantedState
    extends MicrophonePermissionHandlerState {
  const MicrophonePermissionGrantedState();

  @override
  List<Object?> get props => [];
}

final class MicrophonePermissionNotGrantedState
    extends MicrophonePermissionHandlerState {
  const MicrophonePermissionNotGrantedState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}

final class MicrophonePermissionPermanentlyDeniedState
    extends MicrophonePermissionHandlerState {
  const MicrophonePermissionPermanentlyDeniedState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
