import 'package:agora_rtc_engine/agora_rtc_engine.dart';

abstract interface class VideoCallRepository {
  Future<void> initialize(
    String appId,
  );

  Future<void> setupLocalVideo();

  Future<void> startPreview();

// Future<void> enableVideo();
//
// Future<void> disableVideo();
}

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
  Future<void> startPreview() => _videoCallService.startPreview(
        sourceType: VideoSourceType.videoSourceCameraPrimary,
      );

// @override
// Future<void> enableVideo() => _videoCallService.enableVideo();
//
// @override
// Future<void> disableVideo() => _videoCallService.disableVideo();
}
