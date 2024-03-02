// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:permission_handler/permission_handler.dart';
import 'package:vid_call/utils/enums.dart' as enums show PermissionStatus;

abstract final class _PermissionHandlerRepository {
  Future<void> requestPermission();

  Future<enums.PermissionStatus> get status;
}

abstract final class PermissionHandlerSettingsRepository {
  Future<bool> openSettings();
}

abstract final class CameraPermissionHandlerRepository
    implements _PermissionHandlerRepository {}

abstract final class MicrophonePermissionHandlerRepository
    implements _PermissionHandlerRepository {}

final class PermissionHandlerSettingsRepositoryImplementation
    implements PermissionHandlerSettingsRepository {
  @override
  Future<bool> openSettings() => openAppSettings();
}

final class CameraPermissionHandlerRepositoryImplementation
    implements CameraPermissionHandlerRepository {
  @override
  Future<void> requestPermission() => Permission.camera.request();

  @override
  Future<enums.PermissionStatus> get status async =>
      switch (await Permission.camera.status) {
        PermissionStatus.granted ||
        PermissionStatus.limited =>
          enums.PermissionStatus.granted,
        PermissionStatus.permanentlyDenied =>
          enums.PermissionStatus.permanentlyDenied,
        _ => enums.PermissionStatus.notGranted,
      };
}

final class MicrophonePermissionHandlerRepositoryImplementation
    implements MicrophonePermissionHandlerRepository {
  @override
  Future<void> requestPermission() => Permission.microphone.request();

  @override
  Future<enums.PermissionStatus> get status async =>
      switch (await Permission.microphone.status) {
        PermissionStatus.granted ||
        PermissionStatus.limited =>
          enums.PermissionStatus.granted,
        PermissionStatus.permanentlyDenied =>
          enums.PermissionStatus.permanentlyDenied,
        _ => enums.PermissionStatus.notGranted,
      };
}
