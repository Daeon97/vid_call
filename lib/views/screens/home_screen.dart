// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vid_call/cubits/permission/camera_permission_handler_cubit/camera_permission_handler_cubit.dart';
import 'package:vid_call/cubits/permission/microphone_permission_handler_cubit/microphone_permission_handler_cubit.dart';
import 'package:vid_call/cubits/permission/open_permission_settings_cubit/open_permission_settings_cubit.dart';
import 'package:vid_call/cubits/real_time_communication/audio/local/toggle_local_audio_cubit/toggle_local_audio_cubit.dart';
import 'package:vid_call/cubits/real_time_communication/channel/join_channel_cubit/join_channel_cubit.dart';
import 'package:vid_call/cubits/real_time_communication/engine/initialize_real_time_communication_cubit/initialize_real_time_communication_cubit.dart';
import 'package:vid_call/cubits/real_time_communication/video/local/create_local_video_view_cubit/create_local_video_view_cubit.dart';
import 'package:vid_call/cubits/real_time_communication/video/local/toggle_local_preview_cubit/toggle_local_preview_cubit.dart';
import 'package:vid_call/cubits/real_time_communication/video/local/toggle_local_video_cubit/toggle_local_video_cubit.dart';
import 'package:vid_call/resources/colors.dart' show cameraPreviewSurfaceColor;
import 'package:vid_call/resources/numbers/constants.dart'
    show oneDotSix, oneDotTwo;
import 'package:vid_call/resources/numbers/dimensions.dart'
    show largeSpacing, smallSpacing, spacing;
import 'package:vid_call/resources/strings/routes.dart'
    show videoCallScreenRoute;
import 'package:vid_call/resources/strings/ui.dart'
    show cameraIsDisabled, join, request, settings;
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

    randomId = 0;
    // = Random().nextInt(
    //   724569,
    // );

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
          BlocListener<ToggleLocalVideoCubit, ToggleLocalVideoState>(
            listener: (_, toggleLocalVideoState) => context
                .read<ToggleLocalPreviewCubit>()
                .toggleLocalPreview(
                  to: (toggleLocalVideoState is ToggledLocalVideoState &&
                          toggleLocalVideoState.to) ||
                      (toggleLocalVideoState is FailedToToggleLocalVideoState &&
                          !toggleLocalVideoState.to),
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
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.all(
                  spacing,
                ),
                child: Column(
                  children: [
                    BlocBuilder<ToggleLocalVideoCubit, ToggleLocalVideoState>(
                      builder: (_, toggleLocalVideoState) => Container(
                        height: MediaQuery.of(context).size.height / oneDotSix,
                        width: MediaQuery.of(context).size.width / oneDotTwo,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: switch ((toggleLocalVideoState
                                      is ToggledLocalVideoState &&
                                  toggleLocalVideoState.to) ||
                              (toggleLocalVideoState
                                      is FailedToToggleLocalVideoState &&
                                  !toggleLocalVideoState.to)) {
                            true => null,
                            false => cameraPreviewSurfaceColor,
                          },
                        ),
                        child: Center(
                          child: switch ((toggleLocalVideoState
                                      is ToggledLocalVideoState &&
                                  toggleLocalVideoState.to) ||
                              (toggleLocalVideoState
                                      is FailedToToggleLocalVideoState &&
                                  !toggleLocalVideoState.to)) {
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
                            false => Padding(
                                padding: const EdgeInsets.all(
                                  spacing,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.videoSlash,
                                      size: Theme.of(context)
                                          .textTheme
                                          .headlineLarge
                                          ?.fontSize,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    const SizedBox(
                                      height: smallSpacing,
                                    ),
                                    Text(
                                      cameraIsDisabled,
                                      textAlign: TextAlign.center,
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
                              BlocBuilder<ToggleLocalVideoCubit,
                                  ToggleLocalVideoState>(
                            builder: (_, toggleLocalVideoState) =>
                                ElevatedButton(
                              onPressed: switch (cameraPermissionHandlerState) {
                                CameraPermissionGrantedState()
                                    when toggleLocalVideoState
                                            is ToggleLocalVideoInitialState ||
                                        toggleLocalVideoState
                                            is ToggledLocalVideoState ||
                                        toggleLocalVideoState
                                            is FailedToToggleLocalVideoState =>
                                  () => context
                                      .read<ToggleLocalVideoCubit>()
                                      .toggleLocalVideo(
                                        to: toggleLocalVideoState
                                                is ToggleLocalVideoInitialState ||
                                            (toggleLocalVideoState
                                                    is ToggledLocalVideoState &&
                                                !toggleLocalVideoState.to) ||
                                            (toggleLocalVideoState
                                                    is FailedToToggleLocalVideoState &&
                                                toggleLocalVideoState.to),
                                      ),
                                _ => null,
                              },
                              style: const ButtonStyle(
                                shape: MaterialStatePropertyAll<OutlinedBorder>(
                                  CircleBorder(),
                                ),
                                padding: MaterialStatePropertyAll<
                                    EdgeInsetsGeometry>(
                                  EdgeInsetsDirectional.all(
                                    spacing,
                                  ),
                                ),
                              ),
                              child: FaIcon(
                                switch (toggleLocalVideoState) {
                                  ToggledLocalVideoState(
                                    to: final to,
                                  )
                                      when to =>
                                    FontAwesomeIcons.video,
                                  FailedToToggleLocalVideoState(
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
                              BlocBuilder<ToggleLocalAudioCubit,
                                  ToggleLocalAudioState>(
                            builder: (_, toggleLocalAudioState) =>
                                ElevatedButton(
                              onPressed: switch (
                                  microphonePermissionHandlerState) {
                                MicrophonePermissionGrantedState()
                                    when toggleLocalAudioState
                                            is ToggleLocalAudioInitialState ||
                                        toggleLocalAudioState
                                            is ToggledLocalAudioState ||
                                        toggleLocalAudioState
                                            is FailedToToggleLocalAudioState =>
                                  () => context
                                      .read<ToggleLocalAudioCubit>()
                                      .toggleLocalAudio(
                                        to: toggleLocalAudioState
                                                is ToggleLocalAudioInitialState ||
                                            (toggleLocalAudioState
                                                    is ToggledLocalAudioState &&
                                                !toggleLocalAudioState.to) ||
                                            (toggleLocalAudioState
                                                    is FailedToToggleLocalAudioState &&
                                                toggleLocalAudioState.to),
                                      ),
                                _ => null,
                              },
                              style: const ButtonStyle(
                                shape: MaterialStatePropertyAll<OutlinedBorder>(
                                  CircleBorder(),
                                ),
                                padding: MaterialStatePropertyAll<
                                    EdgeInsetsGeometry>(
                                  EdgeInsetsDirectional.all(
                                    spacing,
                                  ),
                                ),
                              ),
                              child: FaIcon(
                                switch (toggleLocalAudioState) {
                                  ToggledLocalAudioState(
                                    to: final to,
                                  )
                                      when to =>
                                    FontAwesomeIcons.microphone,
                                  FailedToToggleLocalAudioState(
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
        ),
      );
}
