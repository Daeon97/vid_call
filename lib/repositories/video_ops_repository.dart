import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import '../utils/enums.dart' show Role;

abstract interface class VideoOpsRepository
    with
        _LocalVideoOpsRepository,
        _ChannelOpsRepository,
        _RemoteVideoOpsRepository {
  Future<void> initialize(
    String appId,
  );

  Future<void> enableVideo();

  Future<void> disableVideo();
}

abstract mixin class _LocalVideoOpsRepository {
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

  Future<void> muteLocalVideoStream();

  Future<void> unMuteLocalVideoStream();

  Future<void> startPreview();

  Future<void> stopPreview();
}

abstract mixin class _ChannelOpsRepository {
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

abstract mixin class _RemoteVideoOpsRepository {
  Future<void> muteRemoteVideoStream(
    int userId,
  );

  Future<void> unMuteRemoteVideoStream(
    int userId,
  );

  Future<void> muteAllRemoteVideoStreams();

  Future<void> unMuteAllRemoteVideoStreams();
}

/* TODO(Daeon97): Modify this implementation to pass calls to a
    util class that can catch and handle errors thrown from Agora */
final class VideoOpsRepositoryImplementation implements VideoOpsRepository {
  const VideoOpsRepositoryImplementation(
    RtcEngine rtcService,
  ) : _rtcService = rtcService;

  final RtcEngine _rtcService;

  @override
  Future<void> initialize(
    String appId,
  ) =>
      _rtcService.initialize(
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
      _rtcService.setupLocalVideo(
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
      _rtcService.setupLocalVideo(
        VideoCanvas(
          view: null,
          uid: userId,
        ),
      );

  @override
  Future<void> enableLocalVideo() => _rtcService.enableLocalVideo(
        true,
      );

  @override
  Future<void> disableLocalVideo() => _rtcService.enableLocalVideo(
        false,
      );

  @override
  Future<void> muteLocalVideoStream() => _rtcService.muteLocalVideoStream(
        true,
      );

  @override
  Future<void> unMuteLocalVideoStream() => _rtcService.muteLocalVideoStream(
        false,
      );

  @override
  Future<void> enableVideo() => _rtcService.enableVideo();

  @override
  Future<void> disableVideo() => _rtcService.disableVideo();

  @override
  Future<void> startPreview() => _rtcService.startPreview(
        sourceType: VideoSourceType.videoSourceCameraPrimary,
      );

  @override
  Future<void> stopPreview() => _rtcService.stopPreview(
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
      _rtcService.joinChannel(
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
  Future<void> leaveChannel() => _rtcService.leaveChannel(
        options: const LeaveChannelOptions(
          stopAudioMixing: true,
          stopMicrophoneRecording: true,
          stopAllEffect: true,
        ),
      );

  @override
  Future<void> muteRemoteVideoStream(
    int userId,
  ) =>
      _rtcService.muteRemoteVideoStream(
        uid: userId,
        mute: true,
      );

  @override
  Future<void> unMuteRemoteVideoStream(
    int userId,
  ) =>
      _rtcService.muteRemoteVideoStream(
        uid: userId,
        mute: false,
      );

  @override
  Future<void> muteAllRemoteVideoStreams() =>
      _rtcService.muteAllRemoteVideoStreams(
        true,
      );

  @override
  Future<void> unMuteAllRemoteVideoStreams() =>
      _rtcService.muteAllRemoteVideoStreams(
        false,
      );
}
