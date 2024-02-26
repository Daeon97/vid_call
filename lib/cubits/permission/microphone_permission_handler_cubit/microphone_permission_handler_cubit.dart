// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/repositories/permission_handler_repository.dart'
    show MicrophonePermissionHandlerRepository;
import 'package:vid_call/resources/strings/ui.dart'
    show
        microphonePermissionIsRequiredToEnableAudio,
        microphonePermissionPermanentlyDenied;
import 'package:vid_call/utils/enums.dart' show PermissionStatus;

part 'microphone_permission_handler_state.dart';

final class MicrophonePermissionHandlerCubit
    extends Cubit<MicrophonePermissionHandlerState> {
  MicrophonePermissionHandlerCubit(
    MicrophonePermissionHandlerRepository microphonePermissionHandlerRepository,
  )   : _microphonePermissionHandlerRepository =
            microphonePermissionHandlerRepository,
        super(
          const MicrophonePermissionHandlerInitialState(),
        );

  final MicrophonePermissionHandlerRepository
      _microphonePermissionHandlerRepository;

  Future<void> get microphonePermission async {
    emit(
      const GettingMicrophonePermissionState(),
    );

    await _microphonePermissionHandlerRepository.requestPermission();

    await microphonePermissionStatus;
  }

  Future<void> get microphonePermissionStatus async {
    final permissionStatus =
        await _microphonePermissionHandlerRepository.status;

    emit(
      switch (permissionStatus) {
        PermissionStatus.granted => const MicrophonePermissionGrantedState(),
        PermissionStatus.notGranted =>
          const MicrophonePermissionNotGrantedState(
            Failure(
              microphonePermissionIsRequiredToEnableAudio,
            ),
          ),
        PermissionStatus.permanentlyDenied =>
          const MicrophonePermissionPermanentlyDeniedState(
            Failure(
              microphonePermissionPermanentlyDenied,
            ),
          ),
      },
    );
  }
}
