// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/repositories/permission_handler_repository.dart'
    show CameraPermissionHandlerRepository;
import 'package:vid_call/resources/strings/ui.dart'
    show
        cameraPermissionIsRequiredToEnableVideo,
        cameraPermissionPermanentlyDenied;
import 'package:vid_call/utils/enums.dart' show PermissionStatus;

part 'camera_permission_handler_state.dart';

final class CameraPermissionHandlerCubit
    extends Cubit<CameraPermissionHandlerState> {
  CameraPermissionHandlerCubit(
    CameraPermissionHandlerRepository cameraPermissionHandlerRepository,
  )   : _cameraPermissionHandlerRepository = cameraPermissionHandlerRepository,
        super(
          const CameraPermissionHandlerInitialState(),
        );

  final CameraPermissionHandlerRepository _cameraPermissionHandlerRepository;

  Future<void> get cameraPermission async {
    emit(
      const GettingCameraPermissionState(),
    );

    await _cameraPermissionHandlerRepository.requestPermission();

    await cameraPermissionStatus;
  }

  Future<void> get cameraPermissionStatus async {
    final permissionStatus = await _cameraPermissionHandlerRepository.status;

    emit(
      switch (permissionStatus) {
        PermissionStatus.granted => const CameraPermissionGrantedState(),
        PermissionStatus.notGranted => const CameraPermissionNotGrantedState(
            Failure(
              cameraPermissionIsRequiredToEnableVideo,
            ),
          ),
        PermissionStatus.permanentlyDenied =>
          const CameraPermissionPermanentlyDeniedState(
            Failure(
              cameraPermissionPermanentlyDenied,
            ),
          ),
      },
    );
  }
}
