// ignore_for_file: public_member_api_docs

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:dartz/dartz.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/resources/strings/ui.dart'
    show failedToJoinChannel, failedToLeaveChannel;
import 'package:vid_call/utils/clients/rtc_operation_handler.dart';

abstract final class ChannelOpsRepository {
  Future<Either<Failure, void>> joinChannel({
    required String token,
    required String channelId,
    required int userId,
  });

  Future<Either<Failure, void>> leaveChannel();
}

final class ChannelOpsRepositoryImplementation
    with RtcOperationHandler
    implements ChannelOpsRepository {
  const ChannelOpsRepositoryImplementation(
    RtcEngine rtcService,
  ) : _rtcService = rtcService;

  final RtcEngine _rtcService;

  @override
  Future<Either<Failure, void>> joinChannel({
    required String token,
    required String channelId,
    required int userId,
  }) =>
      handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.joinChannel(
          token: token,
          channelId: channelId,
          uid: userId,
          options: const ChannelMediaOptions(
            publishCameraTrack: true,
            publishMicrophoneTrack: true,
            enableAudioRecordingOrPlayout: true,
            autoSubscribeAudio: true,
            autoSubscribeVideo: true,
            channelProfile: ChannelProfileType.channelProfileCommunication,
            clientRoleType: ClientRoleType.clientRoleBroadcaster,
            defaultVideoStreamType: VideoStreamType.videoStreamHigh,
          ),
        ),
        failureMessage: failedToJoinChannel,
      );

  @override
  Future<Either<Failure, void>> leaveChannel() => handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.leaveChannel(
          options: const LeaveChannelOptions(
            stopAudioMixing: true,
            stopMicrophoneRecording: true,
            stopAllEffect: true,
          ),
        ),
        failureMessage: failedToLeaveChannel,
      );
}
