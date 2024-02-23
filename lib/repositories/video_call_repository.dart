import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import '../../utils/enums.dart';

abstract interface class VideoCallRepository {
  Future<void> initialize(
    String appId,
  );

  /* TODO(Daeon97): Check out [VideoViewSetupMode] of [VideoCanvas]
      later */
  Future<void> bindLocalVideoToView({
    required int viewId,
    required int userId,
  });

  Future<void> unbindLocalVideoFromView(
    int userId,
  );

  Future<void> enableLocalVideo();

  Future<void> disableLocalVideo();

  Future<void> startLocalVideoStream();

  Future<void> stopLocalVideoStream();

  // Future<void> streamRemoteVideo();

  Future<void> enableVideo();

  Future<void> disableVideo();

  Future<void> startPreview();

  Future<void> stopPreview();

  /* TODO(Daeon97): Publishing screen capture is not supported,
      autoSubscribeAudio and autoSubscribeVideo is set to true */
  Future<void> joinChannel({
    required String token,
    required String channelId,
    required int userId,
    required bool publishCameraFeed,
    required bool publishMicrophoneFeed,
    required Role role,
  });

  Future<void> leaveChannel();
}

/* TODO(Daeon97): Modify this implementation to pass calls to a
    util class that can catch and handle errors thrown from Agora */

final class VideoCallRepositoryImplementation implements VideoCallRepository {
  const VideoCallRepositoryImplementation(
    RtcEngine videoCallService,
  ) : _videoCallService = videoCallService;

  final RtcEngine _videoCallService;

  @override
  Future<void> initialize(
    String appId,
  ) =>
      _videoCallService.initialize(
        RtcEngineContext(
          appId: appId,
          channelProfile: ChannelProfileType.channelProfileCloudGaming,
        ),
      );

  @override
  Future<void> bindLocalVideoToView({
    required int viewId,
    required int userId,
  }) =>
      _videoCallService.setupLocalVideo(
        VideoCanvas(
          view: viewId,
          uid: userId,
          sourceType: VideoSourceType.videoSourceCameraPrimary,
        ),
      );

  @override
  Future<void> unbindLocalVideoFromView(
    int userId,
  ) =>
      _videoCallService.setupLocalVideo(
        VideoCanvas(
          view: null,
          uid: userId,
        ),
      );

  @override
  Future<void> enableLocalVideo() => _videoCallService.enableLocalVideo(
        true,
      );

  @override
  Future<void> disableLocalVideo() => _videoCallService.enableLocalVideo(
        false,
      );

  @override
  Future<void> startLocalVideoStream() =>
      _videoCallService.muteLocalVideoStream(
        false,
      );

  @override
  Future<void> stopLocalVideoStream() => _videoCallService.muteLocalVideoStream(
        true,
      );

  // @override
  // Future<void> streamRemoteVideo() =>
  //     _videoCallService.muteAllRemoteVideoStreams(
  //       false,
  //     );

  @override
  Future<void> enableVideo() => _videoCallService.enableVideo();

  @override
  Future<void> disableVideo() => _videoCallService.disableVideo();

  @override
  Future<void> startPreview() => _videoCallService.startPreview(
        sourceType: VideoSourceType.videoSourceCameraPrimary,
      );

  @override
  Future<void> stopPreview() => _videoCallService.stopPreview(
        sourceType: VideoSourceType.videoSourceCameraPrimary,
      );

  @override
  Future<void> joinChannel({
    required String token,
    required String channelId,
    required int userId,
    required bool publishCameraFeed,
    required bool publishMicrophoneFeed,
    required Role role,
  }) =>
      _videoCallService.joinChannel(
        token: token,
        channelId: channelId,
        uid: userId,
        options: ChannelMediaOptions(
          publishCameraTrack: publishCameraFeed,
          publishMicrophoneTrack: publishMicrophoneFeed,
          enableAudioRecordingOrPlayout: publishMicrophoneFeed,
          autoSubscribeAudio: true,
          autoSubscribeVideo: true,
          channelProfile: ChannelProfileType.channelProfileCloudGaming,
          clientRoleType: switch (role) {
            Role.host => ClientRoleType.clientRoleBroadcaster,
            Role.audience => ClientRoleType.clientRoleAudience,
          },
        ),
      );

  @override
  Future<void> leaveChannel() => _videoCallService.leaveChannel(
        options: const LeaveChannelOptions(
          stopAudioMixing: true,
          stopMicrophoneRecording: true,
          stopAllEffect: true,
        ),
      );
}
