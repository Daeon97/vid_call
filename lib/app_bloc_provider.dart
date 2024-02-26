// ignore_for_file: public_member_api_docs

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vid_call/cubits/permission/camera_permission_handler_cubit/camera_permission_handler_cubit.dart'
    show CameraPermissionHandlerCubit;
import 'package:vid_call/cubits/permission/microphone_permission_handler_cubit/microphone_permission_handler_cubit.dart'
    show MicrophonePermissionHandlerCubit;
import 'package:vid_call/injection_container.dart' show sl;

List<BlocProvider> get appBlocProviders => [
      BlocProvider<CameraPermissionHandlerCubit>(
        create: (_) => sl(),
      ),
      BlocProvider<MicrophonePermissionHandlerCubit>(
        create: (_) => sl(),
      ),
    ];
