// ignore_for_file: public_member_api_docs

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vid_call/cubits/permission/camera_permission_handler_cubit/camera_permission_handler_cubit.dart';
import 'package:vid_call/cubits/permission/microphone_permission_handler_cubit/microphone_permission_handler_cubit.dart';
import 'package:vid_call/cubits/permission/open_permission_settings_cubit/open_permission_settings_cubit.dart';
import 'package:vid_call/cubits/real_time_communication/create_local_video_view_cubit/create_local_video_view_cubit.dart';
import 'package:vid_call/cubits/real_time_communication/initialize_real_time_communication_cubit/initialize_real_time_communication_cubit.dart';
import 'package:vid_call/cubits/real_time_communication/join_channel_cubit/join_channel_cubit.dart';
import 'package:vid_call/cubits/real_time_communication/toggle_audio_cubit/toggle_audio_cubit.dart';
import 'package:vid_call/cubits/real_time_communication/toggle_preview_cubit/toggle_preview_cubit.dart';
import 'package:vid_call/cubits/real_time_communication/toggle_video_cubit/toggle_video_cubit.dart';
import 'package:vid_call/resources/colors.dart' show cameraPreviewSurfaceColor;
import 'package:vid_call/resources/numbers/constants.dart'
    show oneDotFive, oneDotNil, sixteenDotNil, twoDotNil;
import 'package:vid_call/resources/numbers/dimensions.dart'
    show largeSpacing, smallSpacing, spacing;
import 'package:vid_call/resources/strings/routes.dart'
    show videoCallScreenRoute;
import 'package:vid_call/resources/strings/ui.dart'
    show cameraIsDisabled, join, request, settings;
import 'package:vid_call/utils/enums.dart' show Role;
import 'package:vid_call/views/widgets/alert_snack_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _channelIdController;

  late final int randomId;

  @override
  void initState() {
    _channelIdController = TextEditingController();

    randomId = Random().nextInt(
      724569,
    );

    context.read<CameraPermissionHandlerCubit>().cameraPermissionStatus;

    context.read<MicrophonePermissionHandlerCubit>().microphonePermissionStatus;

    super.initState();
  }

  @override
  void dispose() {
    _channelIdController.dispose();

    super.dispose();
  }

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
          BlocListener<CameraPermissionHandlerCubit,
              CameraPermissionHandlerState>(
            listener: (_, cameraPermissionHandlerState) {
              if (cameraPermissionHandlerState
                  is CameraPermissionGrantedState) {
                context
                    .read<InitializeRealTimeCommunicationCubit>()
                    .initializeRealTimeCommunication();
              }
            },
          ),
          BlocListener<InitializeRealTimeCommunicationCubit,
              InitializeRealTimeCommunicationState>(
            listener: (_, initializeRealTimeCommunicationState) {
              if (initializeRealTimeCommunicationState
                  is InitializedRealTimeCommunicationState) {
                context.read<CreateLocalVideoViewCubit>().createLocalVideoView(
                      id: randomId,
                    );
              } else if (initializeRealTimeCommunicationState
                  is FailedToInitializeRealTimeCommunicationState) {
                AlertSnackBar.show(
                  context,
                  message: initializeRealTimeCommunicationState.failure.message,
                );
              }
            },
          ),
          BlocListener<ToggleVideoCubit, ToggleVideoState>(
            listener: (_, toggleVideoState) =>
                context.read<TogglePreviewCubit>().togglePreview(
                      to: (toggleVideoState is ToggledVideoState &&
                              toggleVideoState.to) ||
                          (toggleVideoState is FailedToToggleVideoState &&
                              !toggleVideoState.to),
                    ),
          ),
          BlocListener<JoinChannelCubit, JoinChannelState>(
            listener: (_, joinChannelState) {
              if (joinChannelState is JoinedChannelState) {
                Navigator.of(context).pushNamed(
                  videoCallScreenRoute,
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
                  BlocBuilder<ToggleVideoCubit, ToggleVideoState>(
                    builder: (_, toggleVideoState) => Container(
                      height: MediaQuery.of(context).size.height / twoDotNil,
                      width: MediaQuery.of(context).size.width / oneDotFive,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: switch ((toggleVideoState is ToggledVideoState &&
                                toggleVideoState.to) ||
                            (toggleVideoState is FailedToToggleVideoState &&
                                !toggleVideoState.to)) {
                          true => null,
                          false => cameraPreviewSurfaceColor,
                        },
                      ),
                      child: Center(
                        child: switch ((toggleVideoState is ToggledVideoState &&
                                toggleVideoState.to) ||
                            (toggleVideoState is FailedToToggleVideoState &&
                                !toggleVideoState.to)) {
                          true => BlocBuilder<CreateLocalVideoViewCubit,
                                CreateLocalVideoViewState>(
                              builder: (_, createLocalVideoViewState) =>
                                  switch (createLocalVideoViewState) {
                                CreatedLocalVideoViewState(
                                  agoraVideoView: final agoraVideoView,
                                ) =>
                                  agoraVideoView,
                                _ => const CircularProgressIndicator(),
                              },
                            ),
                          false => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.videoSlash,
                                  size: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.fontSize,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                const SizedBox(
                                  height: smallSpacing,
                                ),
                                Text(
                                  cameraIsDisabled,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                ),
                              ],
                            ),
                        },
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
                            BlocBuilder<ToggleVideoCubit, ToggleVideoState>(
                          builder: (_, toggleVideoState) => ElevatedButton(
                            onPressed: switch (cameraPermissionHandlerState) {
                              CameraPermissionGrantedState()
                                  when toggleVideoState
                                          is ToggleVideoInitialState ||
                                      toggleVideoState is ToggledVideoState ||
                                      toggleVideoState
                                          is FailedToToggleVideoState =>
                                () => context
                                    .read<ToggleVideoCubit>()
                                    .toggleVideo(
                                      to: toggleVideoState
                                              is ToggleVideoInitialState ||
                                          (toggleVideoState
                                                  is ToggledVideoState &&
                                              !toggleVideoState.to) ||
                                          (toggleVideoState
                                                  is FailedToToggleVideoState &&
                                              toggleVideoState.to),
                                    ),
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
                              switch (toggleVideoState) {
                                ToggledVideoState(
                                  to: final to,
                                )
                                    when to =>
                                  FontAwesomeIcons.video,
                                FailedToToggleVideoState(
                                  to: final to,
                                  failure: _,
                                )
                                    when !to =>
                                  FontAwesomeIcons.video,
                                _ => FontAwesomeIcons.videoSlash,
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: spacing,
                      ),
                      BlocBuilder<MicrophonePermissionHandlerCubit,
                          MicrophonePermissionHandlerState>(
                        builder: (_, microphonePermissionHandlerState) =>
                            BlocBuilder<ToggleAudioCubit, ToggleAudioState>(
                          builder: (_, toggleAudioState) => ElevatedButton(
                            onPressed: switch (
                                microphonePermissionHandlerState) {
                              MicrophonePermissionGrantedState()
                                  when toggleAudioState
                                          is ToggleAudioInitialState ||
                                      toggleAudioState is ToggledAudioState ||
                                      toggleAudioState
                                          is FailedToToggleAudioState =>
                                () => context
                                    .read<ToggleAudioCubit>()
                                    .toggleAudio(
                                      to: toggleAudioState
                                              is ToggleAudioInitialState ||
                                          (toggleAudioState
                                                  is ToggledAudioState &&
                                              !toggleAudioState.to) ||
                                          (toggleAudioState
                                                  is FailedToToggleAudioState &&
                                              toggleAudioState.to),
                                    ),
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
                              switch (toggleAudioState) {
                                ToggledAudioState(
                                  to: final to,
                                )
                                    when to =>
                                  FontAwesomeIcons.microphone,
                                FailedToToggleAudioState(
                                  to: final to,
                                  failure: _,
                                )
                                    when !to =>
                                  FontAwesomeIcons.microphone,
                                _ => FontAwesomeIcons.microphoneSlash,
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: spacing,
                      ),
                      BlocBuilder<CreateLocalVideoViewCubit,
                          CreateLocalVideoViewState>(
                        builder: (_, createLocalVideoViewState) =>
                            ElevatedButton(
                          onPressed: () =>
                              context.read<JoinChannelCubit>().joinChannel(
                                    userId: randomId,
                                    role: Role.audience,
                                  ),
                          onLongPress: () =>
                              context.read<JoinChannelCubit>().joinChannel(
                                    userId: randomId,
                                    role: Role.host,
                                  ),
                          style: const ButtonStyle(
                            padding:
                                MaterialStatePropertyAll<EdgeInsetsGeometry>(
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
                              onPressed: () => context
                                  .read<CameraPermissionHandlerCubit>()
                                  .cameraPermission,
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
                              onPressed: () => context
                                  .read<MicrophonePermissionHandlerCubit>()
                                  .microphonePermission,
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
