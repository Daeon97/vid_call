import 'package:permission_handler/permission_handler.dart';
import '../utils/enums.dart' as enums show PermissionStatus;

abstract interface class _PermissionHandlerRepository {
  Future<enums.PermissionStatus> get status;

  Future<void> requestPermission();

  Future<bool> get permissionGranted;

  Future<bool> get permissionDenied;

  Future<bool> get permissionPermanentlyDenied;

// Future<void> openSettings() => openAppSettings();
}

abstract interface class CameraPermissionHandlerRepository
    implements _PermissionHandlerRepository {}

abstract interface class MicrophonePermissionHandlerRepository
    implements _PermissionHandlerRepository {}

final class CameraPermissionHandlerRepositoryImplementation
    implements CameraPermissionHandlerRepository {
  @override
  Future<enums.PermissionStatus> get status async =>
      switch (await Permission.camera.status) {
        PermissionStatus.granted ||
        PermissionStatus.limited =>
          enums.PermissionStatus.granted,
        _ => enums.PermissionStatus.notGranted,
      };

  @override
  Future<void> requestPermission() => Permission.camera.request();

  @override
  Future<bool> get permissionGranted => Permission.camera.isGranted;

  @override
  Future<bool> get permissionDenied => Permission.camera.isDenied;

  @override
  Future<bool> get permissionPermanentlyDenied =>
      Permission.camera.isPermanentlyDenied;
}

final class MicrophonePermissionHandlerRepositoryImplementation
    implements MicrophonePermissionHandlerRepository {
  @override
  Future<enums.PermissionStatus> get status async =>
      switch (await Permission.microphone.status) {
        PermissionStatus.granted ||
        PermissionStatus.limited =>
          enums.PermissionStatus.granted,
        _ => enums.PermissionStatus.notGranted,
      };

  @override
  Future<void> requestPermission() => Permission.microphone.request();

  @override
  Future<bool> get permissionGranted => Permission.microphone.isGranted;

  @override
  Future<bool> get permissionDenied => Permission.microphone.isDenied;

  @override
  Future<bool> get permissionPermanentlyDenied =>
      Permission.microphone.isPermanentlyDenied;
}
