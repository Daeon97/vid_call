// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vid_call/cubits/permission/camera_permission_handler_cubit/camera_permission_handler_cubit.dart';
import 'package:vid_call/cubits/permission/microphone_permission_handler_cubit/microphone_permission_handler_cubit.dart';
import 'package:vid_call/cubits/permission/open_permission_settings_cubit/open_permission_settings_cubit.dart';
import 'package:vid_call/cubits/real_time_communication/initialize_real_time_communication_cubit/initialize_real_time_communication_cubit.dart';
import 'package:vid_call/resources/colors.dart' show cameraPreviewSurfaceColor;
import 'package:vid_call/resources/numbers/constants.dart'
    show oneDotFive, oneDotNil, sixteenDotNil, twoDotNil;
import 'package:vid_call/resources/numbers/dimensions.dart'
    show largeSpacing, smallSpacing, spacing;
import 'package:vid_call/resources/strings/ui.dart'
    show join, request, settings;
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

  Future<void> get _cameraPermission =>
      context.read<CameraPermissionHandlerCubit>().cameraPermission;

  Future<void> get _microphonePermission =>
      context.read<MicrophonePermissionHandlerCubit>().microphonePermission;

  Future<void> _openAppSettings() =>
      context.read<OpenPermissionSettingsCubit>().openAppSettings();

  @override
  Widget build(BuildContext context) => MultiBlocListener(
        listeners: [
          BlocListener<OpenPermissionSettingsCubit,
              OpenPermissionSettingsState>(
            listener: (_, openPermissionSettingsState) {
              if (openPermissionSettingsState
                  is FailedToOpenPermissionSettingsState) {
                AlertSnackBar.show(
                  context,
                  message: openPermissionSettingsState.failure.message,
                );
              }
            },
          ),
          BlocListener<InitializeRealTimeCommunicationCubit,
              InitializeRealTimeCommunicationState>(
            listener: (_, initializeRealTimeCommunicationState) {
              if (initializeRealTimeCommunicationState
                  is InitializedRealTimeCommunicationState) {
                // do necessary stuff here
              } else if (initializeRealTimeCommunicationState
                  is FailedToInitializeRealTimeCommunicationState) {
                AlertSnackBar.show(
                  context,
                  message: initializeRealTimeCommunicationState.failure.message,
                );
              }
            },
          ),
          BlocListener<CameraPermissionHandlerCubit,
              CameraPermissionHandlerState>(
            listener: (_, cameraPermissionHandlerState) {
              if (cameraPermissionHandlerState
                  is CameraPermissionGrantedState) {
                // context
                //     .read<InitializeRealTimeCommunicationCubit>()
                //     .initializeRealTimeCommunication();
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
                    // child: BlocBuilder<InitializeRealTimeCommunicationCubit,
                    //     InitializeRealTimeCommunicationState>(
                    //   builder: (_, initializeRealTimeCommunicationState) =>
                    //       switch (initializeRealTimeCommunicationState) {
                    //     InitializedRealTimeCommunicationState(
                    //       agoraVideoView: final agoraVideoView,
                    //     ) =>
                    //       Center(
                    //         child: agoraVideoView,
                    //       ),
                    //     _ => Center(
                    //         child: SizedBox(
                    //           height: oneDotNil,
                    //           width: MediaQuery.of(context).size.width /
                    //               oneDotFive,
                    //           child: const LinearProgressIndicator(),
                    //         ),
                    //       ),
                    //   },
                    // ),
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
                              () => _cameraPermission,
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
                              () => _microphonePermission,
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
                      const SizedBox(
                        width: spacing,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                          padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                            EdgeInsetsDirectional.symmetric(
                              vertical: spacing,
                              horizontal: largeSpacing + spacing,
                            ),
                          ),
                        ),
                        child: const Text(
                          join,
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
                            TextButton(
                              onPressed: () => _cameraPermission,
                              child: const Text(
                                request,
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
                            TextButton(
                              onPressed: _openAppSettings,
                              child: const Text(
                                settings,
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
                            TextButton(
                              onPressed: () => _microphonePermission,
                              child: const Text(
                                request,
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
                            TextButton(
                              onPressed: _openAppSettings,
                              child: const Text(
                                settings,
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
        ),
      );
}
