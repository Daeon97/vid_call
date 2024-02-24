import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get_it/get_it.dart';
import 'repositories/permission_handler_repository.dart';
import 'repositories/audio_ops_repository.dart';
import 'repositories/video_ops_repository.dart';

final sl = GetIt.I;

void registerServices() {
  sl
    // Repositories
    ..registerLazySingleton<VideoOpsRepository>(
      () => VideoOpsRepositoryImplementation(
        sl(),
      ),
    )
    ..registerLazySingleton<AudioOpsRepository>(
      () => AudioOpsRepositoryImplementation(
        sl(),
      ),
    )
    ..registerLazySingleton<CameraPermissionHandlerRepository>(
      CameraPermissionHandlerRepositoryImplementation.new,
    )
    ..registerLazySingleton<MicrophonePermissionHandlerRepository>(
      MicrophonePermissionHandlerRepositoryImplementation.new,
    )

    // External
    ..registerLazySingleton<RtcEngine>(
      createAgoraRtcEngine,
    );
}
