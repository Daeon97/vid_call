// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vid_call/cubits/permission/camera_permission_handler_cubit/camera_permission_handler_cubit.dart';
import 'package:vid_call/cubits/permission/microphone_permission_handler_cubit/microphone_permission_handler_cubit.dart';
import 'package:vid_call/cubits/real_time_communication/audio/local/toggle_local_audio_cubit/toggle_local_audio_cubit.dart';
import 'package:vid_call/cubits/real_time_communication/engine/listen_real_time_communication_event_cubit/listen_real_time_communication_event_cubit.dart';
import 'package:vid_call/cubits/real_time_communication/video/local/create_local_video_view_cubit/create_local_video_view_cubit.dart';
import 'package:vid_call/cubits/real_time_communication/video/local/toggle_local_video_cubit/toggle_local_video_cubit.dart';
import 'package:vid_call/cubits/real_time_communication/video/remote/create_remote_video_view_cubit/create_remote_video_view_cubit.dart';
import 'package:vid_call/resources/colors.dart' show cameraPreviewSurfaceColor;
import 'package:vid_call/resources/numbers/constants.dart'
    show fiveDotNil, nilDotEight, threeDotNil;
import 'package:vid_call/resources/numbers/dimensions.dart'
    show largeSpacing, smallSpacing, spacing;
import 'package:vid_call/resources/strings/ui.dart'
    show channelJoinedSuccessfully, leave, someoneJoinedTheCall, videoMuted;
import 'package:vid_call/views/widgets/alert_snack_bar.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  @override
  void initState() {
    context
        .read<ListenRealTimeCommunicationEventCubit>()
        .listenRealTimeCommunicationEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocListener<
          ListenRealTimeCommunicationEventCubit,
          ListenRealTimeCommunicationEventState>(
        listener: (_, listenRealTimeCommunicationEventState) {
          if (listenRealTimeCommunicationEventState is ChannelJoinedState) {
            AlertSnackBar.show(
              context,
              message: channelJoinedSuccessfully,
            );
          } else if (listenRealTimeCommunicationEventState
              is RemoteUserJoinedState) {
            AlertSnackBar.show(
              context,
              message: listenRealTimeCommunicationEventState.remoteUserId
                      .toString() +
                  someoneJoinedTheCall,
            );
            context.read<CreateRemoteVideoViewCubit>().createRemoteVideoView(
                  listenRealTimeCommunicationEventState.remoteUserId,
                );
          } else if (listenRealTimeCommunicationEventState
              is RemoteUserLeftState) {
            AlertSnackBar.show(
              context,
              message: listenRealTimeCommunicationEventState.failure.message,
            );
          } else if (listenRealTimeCommunicationEventState
              is FailedToListenRealTimeCommunicationEventState) {
            AlertSnackBar.show(
              context,
              message: listenRealTimeCommunicationEventState.failure.message,
            );
          }
        },
        child: Scaffold(
          body: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              BlocBuilder<CreateRemoteVideoViewCubit,
                  CreateRemoteVideoViewState>(
                builder: (_, createRemoteVideoViewState) => Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    color: switch (createRemoteVideoViewState) {
                      CreatedRemoteVideoViewState(
                        agoraVideoView: _,
                      ) =>
                        null,
                      _ => cameraPreviewSurfaceColor.withOpacity(
                          nilDotEight,
                        ),
                    },
                  ),
                  child: Center(
                    child: switch (createRemoteVideoViewState) {
                      CreatedRemoteVideoViewState(
                        agoraVideoView: final agoraVideoView,
                      ) =>
                        agoraVideoView,
                      _ => const CircularProgressIndicator(),
                    },
                  ),
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsetsDirectional.all(
                    spacing,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: BlocBuilder<ToggleLocalVideoCubit,
                            ToggleLocalVideoState>(
                          builder: (_, toggleLocalVideoState) => Container(
                            height:
                                MediaQuery.of(context).size.height / fiveDotNil,
                            width:
                                MediaQuery.of(context).size.width / threeDotNil,
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
                                          videoMuted,
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
                      ),
                      const SizedBox(
                        height: largeSpacing,
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
                                onPressed: switch (
                                    cameraPermissionHandlerState) {
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
                                  shape:
                                      MaterialStatePropertyAll<OutlinedBorder>(
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
                                  shape:
                                      MaterialStatePropertyAll<OutlinedBorder>(
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
                              onPressed: () {},
                              // context.read<JoinChannelCubit>().joinChannel(
                              //   userId: randomId,
                              //   role: Role.audience,
                              // ),
                              style: const ButtonStyle(
                                padding: MaterialStatePropertyAll<
                                    EdgeInsetsGeometry>(
                                  EdgeInsetsDirectional.symmetric(
                                    vertical: spacing,
                                    horizontal: largeSpacing + spacing,
                                  ),
                                ),
                              ),
                              child: const Text(
                                leave,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
