// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vid_call/cubits/real_time_communication/create_remote_video_view_cubit/create_remote_video_view_cubit.dart';
import 'package:vid_call/cubits/real_time_communication/listen_remote_user_cubit/listen_remote_user_cubit.dart';
import 'package:vid_call/resources/colors.dart' show cameraPreviewSurfaceColor;
import 'package:vid_call/resources/numbers/constants.dart'
    show oneDotFive, oneDotNil, sixteenDotNil, twoDotNil;
import 'package:vid_call/resources/numbers/dimensions.dart' show spacing;
import 'package:vid_call/resources/strings/ui.dart' show someoneJoinedTheCall;
import 'package:vid_call/views/widgets/alert_snack_bar.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  @override
  void initState() {
    context.read<ListenRemoteUserCubit>().listenRemoteUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<ListenRemoteUserCubit, ListenRemoteUserState>(
        listener: (_, listenRemoteUserState) {
          if (listenRemoteUserState is RemoteUserJoinedState) {
            AlertSnackBar.show(
              context,
              message: listenRemoteUserState.remoteUserId.toString() +
                  someoneJoinedTheCall,
            );

            context.read<CreateRemoteVideoViewCubit>().createRemoteVideoView(
                  listenRemoteUserState.remoteUserId,
                );
          } else if (listenRemoteUserState is RemoteUserLeftState) {
            AlertSnackBar.show(
              context,
              message: listenRemoteUserState.failure.message,
            );
          } else if (listenRemoteUserState is ListenRemoteUserFailedState) {
            AlertSnackBar.show(
              context,
              message: listenRemoteUserState.failure.message,
            );
          }
        },
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.all(
                spacing,
              ),
              child: Column(
                children: [
                  BlocBuilder<CreateRemoteVideoViewCubit,
                      CreateRemoteVideoViewState>(
                    builder: (_, createRemoteVideoViewState) => Container(
                      height: MediaQuery.of(context).size.height / twoDotNil,
                      width: MediaQuery.of(context).size.width / oneDotFive,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: switch (createRemoteVideoViewState) {
                          CreatedRemoteVideoViewState(
                            agoraVideoView: _,
                          ) =>
                            null,
                          _ => cameraPreviewSurfaceColor,
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
                ],
              ),
            ),
          ),
        ),
      );
}
