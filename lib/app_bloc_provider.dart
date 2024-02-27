// ignore_for_file: public_member_api_docs

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vid_call/cubits/permission/camera_permission_handler_cubit/camera_permission_handler_cubit.dart'
    show CameraPermissionHandlerCubit;
import 'package:vid_call/cubits/permission/microphone_permission_handler_cubit/microphone_permission_handler_cubit.dart'
    show MicrophonePermissionHandlerCubit;
import 'package:vid_call/cubits/permission/open_permission_settings_cubit/open_permission_settings_cubit.dart'
    show OpenPermissionSettingsCubit;
import 'package:vid_call/cubits/real_time_communication/create_video_view_cubit/create_video_view_cubit.dart'
    show CreateVideoViewCubit;
import 'package:vid_call/cubits/real_time_communication/initialize_real_time_communication_cubit/initialize_real_time_communication_cubit.dart'
    show InitializeRealTimeCommunicationCubit;
import 'package:vid_call/cubits/real_time_communication/toggle_audio_cubit/toggle_audio_cubit.dart'
    show ToggleAudioCubit;
import 'package:vid_call/cubits/real_time_communication/toggle_preview_cubit/toggle_preview_cubit.dart'
    show TogglePreviewCubit;
import 'package:vid_call/cubits/real_time_communication/toggle_video_cubit/toggle_video_cubit.dart'
    show ToggleVideoCubit;
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
      BlocProvider<CreateVideoViewCubit>(
        create: (_) => sl(),
      ),
      BlocProvider<ToggleAudioCubit>(
        create: (_) => sl(),
      ),
      BlocProvider<TogglePreviewCubit>(
        create: (_) => sl(),
      ),
      BlocProvider<ToggleVideoCubit>(
        create: (_) => sl(),
      ),
    ];
