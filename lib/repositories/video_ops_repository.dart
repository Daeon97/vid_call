// ignore_for_file: public_member_api_docs

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:dartz/dartz.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/utils/clients/rtc_operation_handler.dart';
import 'package:vid_call/utils/enums.dart' show Role;
import 'package:vid_call/utils/type_definitions.dart'
    show OnVideoViewCreatedCallback;

abstract interface class VideoOpsRepository
    with
        _LocalVideoOpsRepository,
        _ChannelOpsRepository,
        _RemoteVideoOpsRepository {
  Future<Either<Failure, void>> initialize(
    String appId,
  );

  AgoraVideoView createVideoView(
    RtcEngine rtcEngine, {
    required int viewId,
    required int userId,
    required OnVideoViewCreatedCallback onVideoViewCreated,
  });

  Future<Either<Failure, void>> registerEventHandler(
    RtcEngineEventHandler eventHandler,
  );

  Future<Either<Failure, void>> enableVideo();

  Future<Either<Failure, void>> disableVideo();
}

abstract mixin class _LocalVideoOpsRepository {
  /* TODO(Daeon97): Check out [VideoViewSetupMode] of [VideoCanvas]
      later */
  Future<Either<Failure, void>> bindLocalVideoToView({
    required int viewId,
    required int userId,
  });

  Future<Either<Failure, void>> unbindLocalVideoFromView(
    int userId,
  );

  Future<Either<Failure, void>> enableLocalVideo();

  Future<Either<Failure, void>> disableLocalVideo();

  Future<Either<Failure, void>> muteLocalVideoStream();

  Future<Either<Failure, void>> unMuteLocalVideoStream();

  Future<Either<Failure, void>> startPreview();

  Future<Either<Failure, void>> stopPreview();
}

abstract mixin class _ChannelOpsRepository {
  /* TODO(Daeon97): Publishing screen capture is not supported,
      autoSubscribeAudio and autoSubscribeVideo is set to true */
  Future<Either<Failure, void>> joinChannel({
    required String token,
    required String channelId,
    required int userId,
    required Role role,
    bool? publishCameraFeed,
    bool? publishMicrophoneFeed,
  });

  Future<Either<Failure, void>> leaveChannel();
}

abstract mixin class _RemoteVideoOpsRepository {
  Future<Either<Failure, void>> bindRemoteVideoToCanvas(
    VideoCanvas canvas,
  );

  Future<Either<Failure, void>> unbindRemoteVideoFromCanvas();

  Future<Either<Failure, void>> muteRemoteVideoStream(
    int userId,
  );

  Future<Either<Failure, void>> unMuteRemoteVideoStream(
    int userId,
  );

  Future<Either<Failure, void>> muteAllRemoteVideoStreams();

  Future<Either<Failure, void>> unMuteAllRemoteVideoStreams();
}

/* TODO(Daeon97): Modify this implementation to pass calls to a
    util class that can catch and handle errors thrown from Agora
    and return an Either<L, R> */
final class VideoOpsRepositoryImplementation
    with RtcOperationHandler
    implements VideoOpsRepository {
  const VideoOpsRepositoryImplementation(
    RtcEngine rtcService,
  ) : _rtcService = rtcService;

  final RtcEngine _rtcService;

  @override
  Future<Either<Failure, void>> initialize(
    String appId,
  ) =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.initialize(
          RtcEngineContext(
            appId: appId,
            channelProfile: ChannelProfileType.channelProfileCloudGaming,
          ),
        ),
        failureHandler: Failure.new,
      );

  @override
  AgoraVideoView createVideoView(
    RtcEngine rtcEngine, {
    required int viewId,
    required int userId,
    required OnVideoViewCreatedCallback onVideoViewCreated,
  }) =>
      AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: rtcEngine,
          canvas: VideoCanvas(
            view: viewId,
            uid: userId,
            sourceType: VideoSourceType.videoSourceCameraPrimary,
          ),
          useFlutterTexture: true,
          useAndroidSurfaceView: true,
        ),
        onAgoraVideoViewCreated: onVideoViewCreated,
      );

  @override
  Future<Either<Failure, void>> registerEventHandler(
    RtcEngineEventHandler eventHandler,
  ) =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () async => _rtcService.registerEventHandler(
          eventHandler,
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> bindLocalVideoToView({
    required int viewId,
    required int userId,
  }) =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.setupLocalVideo(
          VideoCanvas(
            view: viewId,
            uid: userId,
            sourceType: VideoSourceType.videoSourceCameraPrimary,
          ),
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> unbindLocalVideoFromView(
    int userId,
  ) =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.setupLocalVideo(
          VideoCanvas(
            uid: userId,
          ),
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> enableLocalVideo() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.enableLocalVideo(
          true,
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> disableLocalVideo() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.enableLocalVideo(
          false,
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> muteLocalVideoStream() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.muteLocalVideoStream(
          true,
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> unMuteLocalVideoStream() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.muteLocalVideoStream(
          false,
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> enableVideo() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: _rtcService.enableVideo,
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> disableVideo() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: _rtcService.disableVideo,
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> startPreview() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: _rtcService.startPreview,
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> stopPreview() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: _rtcService.stopPreview,
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> joinChannel({
    required String token,
    required String channelId,
    required int userId,
    required Role role,
    bool? publishCameraFeed,
    bool? publishMicrophoneFeed,
  }) =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.joinChannel(
          token: token,
          channelId: channelId,
          uid: userId,
          options: ChannelMediaOptions(
            publishCameraTrack: publishCameraFeed ?? true,
            publishMicrophoneTrack: publishMicrophoneFeed ?? true,
            enableAudioRecordingOrPlayout: publishMicrophoneFeed ?? true,
            autoSubscribeAudio: true,
            autoSubscribeVideo: true,
            channelProfile: ChannelProfileType.channelProfileCloudGaming,
            clientRoleType: switch (role) {
              Role.host => ClientRoleType.clientRoleBroadcaster,
              Role.audience => ClientRoleType.clientRoleAudience,
            },
          ),
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> leaveChannel() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.leaveChannel(
          options: const LeaveChannelOptions(
            stopAudioMixing: true,
            stopMicrophoneRecording: true,
            stopAllEffect: true,
          ),
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> bindRemoteVideoToCanvas(
    VideoCanvas canvas,
  ) =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.setupRemoteVideo(
          canvas,
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> unbindRemoteVideoFromCanvas() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.setupRemoteVideo(
          const VideoCanvas(),
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> muteRemoteVideoStream(
    int userId,
  ) =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.muteRemoteVideoStream(
          uid: userId,
          mute: true,
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> unMuteRemoteVideoStream(
    int userId,
  ) =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.muteRemoteVideoStream(
          uid: userId,
          mute: false,
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> muteAllRemoteVideoStreams() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.muteAllRemoteVideoStreams(
          true,
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> unMuteAllRemoteVideoStreams() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.muteAllRemoteVideoStreams(
          false,
        ),
        failureHandler: Failure.new,
      );
}
