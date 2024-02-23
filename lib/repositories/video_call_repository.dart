import 'package:agora_rtc_engine/agora_rtc_engine.dart';

abstract interface class VideoCallRepository {
  Future<void> initialize(
    String appId,
  );

  // Don't forget to unbind
  Future<void> setupLocalVideo();

  Future<void> enableVideo();

  Future<void> disableVideo();

  Future<void> startPreview();

// Future<void> enableLocalVideo();
//
// Future<void> streamLocalVideo();
//
// Future<void> streamRemoteVideo();
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
        ),
      );

  @override
  Future<void> setupLocalVideo() => _videoCallService.setupLocalVideo(
        const VideoCanvas(
          sourceType: VideoSourceType.videoSourceCameraPrimary,
        ),
      );

  @override
  Future<void> enableVideo() => _videoCallService.enableVideo();

  @override
  Future<void> disableVideo() => _videoCallService.disableVideo();

  @override
  Future<void> startPreview() => _videoCallService.startPreview(
        sourceType: VideoSourceType.videoSourceCameraPrimary,
      );

  @override
  Future<void> enableLocalVideo() => _videoCallService.enableLocalVideo(
    true,
  );

  @override
  Future<void> streamLocalVideo() => _videoCallService.muteLocalVideoStream(
    false,
  );

  @override
  Future<void> streamRemoteVideo() =>
      _videoCallService.muteAllRemoteVideoStreams(
        false,
      );
}
