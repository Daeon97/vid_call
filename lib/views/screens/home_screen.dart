// ignore_for_file: public_member_api_docs

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vid_call/cubits/permission/camera_permission_handler_cubit/camera_permission_handler_cubit.dart';
import 'package:vid_call/cubits/permission/microphone_permission_handler_cubit/microphone_permission_handler_cubit.dart';
import 'package:vid_call/resources/colors.dart' show cameraPreviewSurfaceColor;
import 'package:vid_call/resources/numbers/constants.dart'
    show oneDotFive, sixteenDotNil, twoDotNil;
import 'package:vid_call/resources/numbers/dimensions.dart'
    show largeSpacing, smallSpacing, spacing;
import 'package:vid_call/views/widgets/alert_snack_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _channelIdController;

  @override
  void initState() {
    _channelIdController = TextEditingController();

    context.read<CameraPermissionHandlerCubit>().cameraPermissionStatus;

    context.read<MicrophonePermissionHandlerCubit>().microphonePermissionStatus;

    super.initState();
  }

  @override
  void dispose() {
    _channelIdController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiBlocListener(
        listeners: [
          BlocListener<CameraPermissionHandlerCubit,
              CameraPermissionHandlerState>(
            listener: (_, cameraPermissionHandlerState) {
              if (cameraPermissionHandlerState
                  is CameraPermissionNotGrantedState) {
                AlertSnackBar.show(
                  context,
                  message: cameraPermissionHandlerState.failure.message,
                );
              } else if (cameraPermissionHandlerState
                  is CameraPermissionPermanentlyDeniedState) {
                AlertSnackBar.show(
                  context,
                  message: cameraPermissionHandlerState.failure.message,
                );
              }
            },
          ),
          BlocListener<MicrophonePermissionHandlerCubit,
              MicrophonePermissionHandlerState>(
            listener: (_, microphonePermissionHandlerState) {
              if (microphonePermissionHandlerState
                  is MicrophonePermissionNotGrantedState) {
                AlertSnackBar.show(
                  context,
                  message: microphonePermissionHandlerState.failure.message,
                );
              } else if (microphonePermissionHandlerState
                  is MicrophonePermissionPermanentlyDeniedState) {
                AlertSnackBar.show(
                  context,
                  message: microphonePermissionHandlerState.failure.message,
                );
              }
            },
          ),
        ],
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.all(
                spacing,
              ),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / twoDotNil,
                    width: MediaQuery.of(context).size.width / oneDotFive,
                    decoration: BoxDecoration(
                      color: cameraPreviewSurfaceColor,
                      borderRadius: BorderRadiusDirectional.circular(
                        sixteenDotNil,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: spacing,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocBuilder<CameraPermissionHandlerCubit,
                          CameraPermissionHandlerState>(
                        builder: (_, cameraPermissionHandlerState) =>
                            ElevatedButton(
                          onPressed: switch (cameraPermissionHandlerState) {
                            CameraPermissionGrantedState() => () {},
                            CameraPermissionNotGrantedState(
                              failure: final _,
                            ) =>
                              () => context
                                  .read<CameraPermissionHandlerCubit>()
                                  .cameraPermission,
                            _ => null,
                          },
                          style: const ButtonStyle(
                            shape: MaterialStatePropertyAll<OutlinedBorder>(
                              CircleBorder(),
                            ),
                            padding:
                                MaterialStatePropertyAll<EdgeInsetsGeometry>(
                              EdgeInsetsDirectional.all(
                                spacing,
                              ),
                            ),
                          ),
                          child: FaIcon(
                            switch (cameraPermissionHandlerState) {
                              CameraPermissionGrantedState() =>
                                FontAwesomeIcons.video,
                              _ => FontAwesomeIcons.videoSlash,
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: spacing,
                      ),
                      BlocBuilder<MicrophonePermissionHandlerCubit,
                          MicrophonePermissionHandlerState>(
                        builder: (_, microphonePermissionHandlerState) =>
                            ElevatedButton(
                          onPressed: switch (microphonePermissionHandlerState) {
                            MicrophonePermissionGrantedState() => () {},
                            MicrophonePermissionNotGrantedState(
                              failure: final _,
                            ) =>
                              () => context
                                  .read<MicrophonePermissionHandlerCubit>()
                                  .microphonePermission,
                            _ => null,
                          },
                          style: const ButtonStyle(
                            shape: MaterialStatePropertyAll<OutlinedBorder>(
                              CircleBorder(),
                            ),
                            padding:
                                MaterialStatePropertyAll<EdgeInsetsGeometry>(
                              EdgeInsetsDirectional.all(
                                spacing,
                              ),
                            ),
                          ),
                          child: FaIcon(
                            switch (microphonePermissionHandlerState) {
                              MicrophonePermissionGrantedState() =>
                                FontAwesomeIcons.microphone,
                              _ => FontAwesomeIcons.microphoneSlash,
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: largeSpacing,
                  ),
                  BlocBuilder<CameraPermissionHandlerCubit,
                      CameraPermissionHandlerState>(
                    builder: (_, cameraPermissionHandlerState) =>
                        switch (cameraPermissionHandlerState) {
                      CameraPermissionNotGrantedState(
                        failure: final failure,
                      ) =>
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.triangleExclamation,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            const SizedBox(
                              width: smallSpacing,
                            ),
                            Expanded(
                              child: Text(
                                failure.message,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      CameraPermissionPermanentlyDeniedState(
                        failure: final failure,
                      ) =>
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.triangleExclamation,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            const SizedBox(
                              width: smallSpacing,
                            ),
                            Expanded(
                              child: Text(
                                failure.message,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      _ => const SizedBox.shrink(),
                    },
                  ),
                  BlocBuilder<MicrophonePermissionHandlerCubit,
                      MicrophonePermissionHandlerState>(
                    builder: (_, microphonePermissionHandlerState) =>
                        switch (microphonePermissionHandlerState) {
                      MicrophonePermissionNotGrantedState(
                        failure: final failure,
                      ) =>
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.triangleExclamation,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            const SizedBox(
                              width: smallSpacing,
                            ),
                            Expanded(
                              child: Text(
                                failure.message,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      MicrophonePermissionPermanentlyDeniedState(
                        failure: final failure,
                      ) =>
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.triangleExclamation,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            const SizedBox(
                              width: smallSpacing,
                            ),
                            Expanded(
                              child: Text(
                                failure.message,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      _ => const SizedBox.shrink(),
                    },
                  ),
                ],
              ),
            ),
          ),
          //   AgoraVideoView(
          //     controller: VideoViewController(
          //         rtcEngine: // Pass in the engine instance created on initState,
          //         canvas: VideoCanvas(),
          //     useFlutterTexture: true,
          //     useAndroidSurfaceView: true,
          //   ),
          // ),
        ),
      );
}
