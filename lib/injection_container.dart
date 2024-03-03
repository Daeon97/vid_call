// ignore_for_file: public_member_api_docs

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:vid_call/cubits/permission/camera_permission_handler_cubit/camera_permission_handler_cubit.dart'
    show CameraPermissionHandlerCubit;
import 'package:vid_call/cubits/permission/microphone_permission_handler_cubit/microphone_permission_handler_cubit.dart'
    show MicrophonePermissionHandlerCubit;
import 'package:vid_call/cubits/permission/open_permission_settings_cubit/open_permission_settings_cubit.dart'
    show OpenPermissionSettingsCubit;
import 'package:vid_call/cubits/real_time_communication/audio/local/toggle_local_audio_cubit/toggle_local_audio_cubit.dart'
    show ToggleLocalAudioCubit;
import 'package:vid_call/cubits/real_time_communication/channel/join_channel_cubit/join_channel_cubit.dart'
    show JoinChannelCubit;
import 'package:vid_call/cubits/real_time_communication/channel/leave_channel_cubit/leave_channel_cubit.dart'
    show LeaveChannelCubit;
import 'package:vid_call/cubits/real_time_communication/engine/initialize_real_time_communication_cubit/initialize_real_time_communication_cubit.dart'
    show InitializeRealTimeCommunicationCubit;
import 'package:vid_call/cubits/real_time_communication/engine/real_time_communication_event_cubit/real_time_communication_event_cubit.dart'
    show RealTimeCommunicationEventCubit;
import 'package:vid_call/cubits/real_time_communication/video/local/create_local_video_view_cubit/create_local_video_view_cubit.dart'
    show CreateLocalVideoViewCubit;
import 'package:vid_call/cubits/real_time_communication/video/local/toggle_local_preview_cubit/toggle_local_preview_cubit.dart'
    show ToggleLocalPreviewCubit;
import 'package:vid_call/cubits/real_time_communication/video/local/toggle_local_video_cubit/toggle_local_video_cubit.dart'
    show ToggleLocalVideoCubit;
import 'package:vid_call/cubits/real_time_communication/video/remote/create_remote_video_view_cubit/create_remote_video_view_cubit.dart'
    show CreateRemoteVideoViewCubit;
import 'package:vid_call/repositories/audio_ops_repository.dart';
import 'package:vid_call/repositories/channel_ops_repository.dart';
import 'package:vid_call/repositories/permission_handler_repository.dart';
import 'package:vid_call/repositories/rtc_engine_ops_repository.dart';
import 'package:vid_call/repositories/video_ops_repository.dart';
import 'package:vid_call/resources/strings/environment.dart' show appId;

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
    ..registerFactory<InitializeRealTimeCommunicationCubit>(
      () => InitializeRealTimeCommunicationCubit(
        appId: sl(
          instanceName: appId,
        ),
        rtcEngineOpsRepository: sl(),
      ),
    )
    ..registerFactory<CreateLocalVideoViewCubit>(
      () => CreateLocalVideoViewCubit(
        rtcEngine: sl(),
        localVideoOpsRepository: sl(),
      ),
    )
    ..registerFactory<ToggleLocalAudioCubit>(
      () => ToggleLocalAudioCubit(
        sl(),
      ),
    )
    ..registerFactory<ToggleLocalPreviewCubit>(
      () => ToggleLocalPreviewCubit(
        sl(),
      ),
    )
    ..registerFactory<ToggleLocalVideoCubit>(
      () => ToggleLocalVideoCubit(
        sl(),
      ),
    )
    ..registerFactory<CreateRemoteVideoViewCubit>(
      () => CreateRemoteVideoViewCubit(
        rtcEngine: sl(),
        remoteVideoOpsRepository: sl(),
      ),
    )
    ..registerFactory<RealTimeCommunicationEventCubit>(
      () => RealTimeCommunicationEventCubit(
        sl(),
      ),
    )
    ..registerFactory<JoinChannelCubit>(
      () => JoinChannelCubit(
        sl(),
      ),
    )
    ..registerFactory<LeaveChannelCubit>(
      () => LeaveChannelCubit(
        sl(),
      ),
    )

    // Repositories
    ..registerLazySingleton<RtcEngineOpsRepository>(
      () => RtcEngineOpsRepositoryImplementation(
        sl(),
      ),
    )
    ..registerLazySingleton<LocalVideoOpsRepository>(
      () => LocalVideoOpsRepositoryImplementation(
        sl(),
      ),
    )
    ..registerLazySingleton<RemoteVideoOpsRepository>(
      RemoteVideoOpsRepositoryImplementation.new,
    )
    ..registerLazySingleton<ChannelOpsRepository>(
      () => ChannelOpsRepositoryImplementation(
        sl(),
      ),
    )
    ..registerLazySingleton<LocalAudioOpsRepository>(
      () => LocalAudioOpsRepositoryImplementation(
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
    )

    // Primitives
    ..registerLazySingleton<String>(
      () => dotenv.env[appId]!,
      instanceName: appId,
    );
}
