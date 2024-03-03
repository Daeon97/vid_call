// ignore_for_file: public_member_api_docs

import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:vid_call/injection_container.dart' show sl;

List<BlocProvider> get appBlocProviders => [
      BlocProvider<CameraPermissionHandlerCubit>(
        create: (_) => sl(),
      ),
      BlocProvider<MicrophonePermissionHandlerCubit>(
        create: (_) => sl(),
      ),
      BlocProvider<OpenPermissionSettingsCubit>(
        create: (_) => sl(),
      ),
      BlocProvider<InitializeRealTimeCommunicationCubit>(
        create: (_) => sl(),
      ),
      BlocProvider<CreateLocalVideoViewCubit>(
        create: (_) => sl(),
      ),
      BlocProvider<ToggleLocalAudioCubit>(
        create: (_) => sl(),
      ),
      BlocProvider<ToggleLocalPreviewCubit>(
        create: (_) => sl(),
      ),
      BlocProvider<ToggleLocalVideoCubit>(
        create: (_) => sl(),
      ),
      BlocProvider<CreateRemoteVideoViewCubit>(
        create: (_) => sl(),
      ),
      BlocProvider<RealTimeCommunicationEventCubit>(
        create: (_) => sl(),
      ),
      BlocProvider<JoinChannelCubit>(
        create: (_) => sl(),
      ),
      BlocProvider<LeaveChannelCubit>(
        create: (_) => sl(),
      ),
    ];
