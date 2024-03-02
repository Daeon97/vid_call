// ignore_for_file: public_member_api_docs

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:dartz/dartz.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/resources/strings/ui.dart'
    show
        failedToBindLocalVideoToView,
        failedToBindRemoteVideoToCanvas,
        failedToDisableLocalVideo,
        failedToEnableLocalVideo,
        failedToMuteAllRemoteVideoStreams,
        failedToMuteLocalVideoStream,
        failedToMuteRemoteVideoStream,
        failedToStartLocalVideoPreview,
        failedToStopLocalVideoPreview,
        failedToUnMuteAllRemoteVideoStreams,
        failedToUnMuteLocalVideoStream,
        failedToUnMuteRemoteVideoStream,
        failedToUnbindLocalVideoFromView,
        failedToUnbindRemoteVideoFromCanvas;
import 'package:vid_call/utils/clients/rtc_operation_handler.dart';

abstract final class LocalVideoOpsRepository {
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

  AgoraVideoView createLocalVideoView(
    RtcEngine rtcEngine, {
    required int viewId,
    required int userId,
  });

  Future<Either<Failure, void>> startLocalPreview();

  Future<Either<Failure, void>> stopLocalPreview();
}

abstract final class RemoteVideoOpsRepository {
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

  AgoraVideoView createRemoteVideoView(
    RtcEngine rtcEngine, {
    required int viewId,
    required int userId,
    required String channelId,
  });

  Future<Either<Failure, void>> muteAllRemoteVideoStreams();

  Future<Either<Failure, void>> unMuteAllRemoteVideoStreams();
}

final class LocalVideoOpsRepositoryImplementation
    with RtcOperationHandler
    implements LocalVideoOpsRepository {
  const LocalVideoOpsRepositoryImplementation(
    RtcEngine rtcService,
  ) : _rtcService = rtcService;

  final RtcEngine _rtcService;

  @override
  Future<Either<Failure, void>> bindLocalVideoToView({
    required int viewId,
    required int userId,
  }) =>
      handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.setupLocalVideo(
          VideoCanvas(
            view: viewId,
            uid: userId,
            sourceType: VideoSourceType.videoSourceCameraPrimary,
          ),
        ),
        failureMessage: failedToBindLocalVideoToView,
      );

  @override
  Future<Either<Failure, void>> unbindLocalVideoFromView(
    int userId,
  ) =>
      handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.setupLocalVideo(
          VideoCanvas(
            uid: userId,
          ),
        ),
        failureMessage: failedToUnbindLocalVideoFromView,
      );

  @override
  Future<Either<Failure, void>> enableLocalVideo() => handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.enableLocalVideo(
          true,
        ),
        failureMessage: failedToEnableLocalVideo,
      );

  @override
  Future<Either<Failure, void>> disableLocalVideo() => handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.enableLocalVideo(
          false,
        ),
        failureMessage: failedToDisableLocalVideo,
      );

  @override
  Future<Either<Failure, void>> muteLocalVideoStream() =>
      handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.muteLocalVideoStream(
          true,
        ),
        failureMessage: failedToMuteLocalVideoStream,
      );

  @override
  Future<Either<Failure, void>> unMuteLocalVideoStream() =>
      handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.muteLocalVideoStream(
          false,
        ),
        failureMessage: failedToUnMuteLocalVideoStream,
      );

  @override
  AgoraVideoView createLocalVideoView(
    RtcEngine rtcEngine, {
    required int viewId,
    required int userId,
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
      );

  @override
  Future<Either<Failure, void>> startLocalPreview() => handleRtcOperation<void>(
        rtcOperationInitiator: _rtcService.startPreview,
        failureMessage: failedToStartLocalVideoPreview,
      );

  @override
  Future<Either<Failure, void>> stopLocalPreview() => handleRtcOperation<void>(
        rtcOperationInitiator: _rtcService.stopPreview,
        failureMessage: failedToStopLocalVideoPreview,
      );
}

final class RemoteVideoOpsRepositoryImplementation
    with RtcOperationHandler
    implements RemoteVideoOpsRepository {
  const RemoteVideoOpsRepositoryImplementation(
    RtcEngine rtcService,
  ) : _rtcService = rtcService;

  final RtcEngine _rtcService;

  @override
  Future<Either<Failure, void>> bindRemoteVideoToCanvas(
    VideoCanvas canvas,
  ) =>
      handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.setupRemoteVideo(
          canvas,
        ),
        failureMessage: failedToBindRemoteVideoToCanvas,
      );

  @override
  Future<Either<Failure, void>> unbindRemoteVideoFromCanvas() =>
      handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.setupRemoteVideo(
          const VideoCanvas(),
        ),
        failureMessage: failedToUnbindRemoteVideoFromCanvas,
      );

  @override
  Future<Either<Failure, void>> muteRemoteVideoStream(
    int userId,
  ) =>
      handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.muteRemoteVideoStream(
          uid: userId,
          mute: true,
        ),
        failureMessage: failedToMuteRemoteVideoStream,
      );

  @override
  Future<Either<Failure, void>> unMuteRemoteVideoStream(
    int userId,
  ) =>
      handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.muteRemoteVideoStream(
          uid: userId,
          mute: false,
        ),
        failureMessage: failedToUnMuteRemoteVideoStream,
      );

  @override
  AgoraVideoView createRemoteVideoView(
    RtcEngine rtcEngine, {
    required int viewId,
    required int userId,
    required String channelId,
  }) =>
      AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: rtcEngine,
          canvas: VideoCanvas(
            view: viewId,
            uid: userId,
            sourceType: VideoSourceType.videoSourceRemote,
          ),
          connection: RtcConnection(
            channelId: channelId,
          ),
          useFlutterTexture: true,
          useAndroidSurfaceView: true,
        ),
      );

  @override
  Future<Either<Failure, void>> muteAllRemoteVideoStreams() =>
      handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.muteAllRemoteVideoStreams(
          true,
        ),
        failureMessage: failedToMuteAllRemoteVideoStreams,
      );

  @override
  Future<Either<Failure, void>> unMuteAllRemoteVideoStreams() =>
      handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.muteAllRemoteVideoStreams(
          false,
        ),
        failureMessage: failedToUnMuteAllRemoteVideoStreams,
      );
}
