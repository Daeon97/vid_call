// ignore_for_file: public_member_api_docs

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get_it/get_it.dart';
import 'package:vid_call/cubits/permission/camera_permission_handler_cubit/camera_permission_handler_cubit.dart'
    show CameraPermissionHandlerCubit;
import 'package:vid_call/cubits/permission/microphone_permission_handler_cubit/microphone_permission_handler_cubit.dart'
    show MicrophonePermissionHandlerCubit;
import 'package:vid_call/cubits/permission/open_permission_settings_cubit/open_permission_settings_cubit.dart'
    show OpenPermissionSettingsCubit;
import 'package:vid_call/repositories/audio_ops_repository.dart';
import 'package:vid_call/repositories/permission_handler_repository.dart';
import 'package:vid_call/repositories/video_ops_repository.dart';

final sl = GetIt.I;

void registerServices() {
  sl
    // Cubits
    ..registerFactory<CameraPermissionHandlerCubit>(
      () => CameraPermissionHandlerCubit(
        sl(),
      ),
    )
    ..registerFactory<MicrophonePermissionHandlerCubit>(
      () => MicrophonePermissionHandlerCubit(
        sl(),
      ),
    )
    ..registerFactory<OpenPermissionSettingsCubit>(
      () => OpenPermissionSettingsCubit(
        sl(),
      ),
    )

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
    ..registerLazySingleton<PermissionHandlerSettingsRepository>(
      PermissionHandlerSettingsRepositoryImplementation.new,
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
