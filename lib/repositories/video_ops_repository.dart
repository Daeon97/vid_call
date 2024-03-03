// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:dartz/dartz.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/resources/strings/ui.dart'
    show
        failedToDisableLocalVideo,
        failedToEnableLocalVideo,
        failedToStartLocalVideoPreview,
        failedToStopLocalVideoPreview;
import 'package:vid_call/utils/clients/rtc_operation_handler.dart';

abstract final class LocalVideoOpsRepository {
  Future<Either<Failure, void>> enableLocalVideo();

  Future<Either<Failure, void>> disableLocalVideo();

  AgoraVideoView createLocalVideoView(
    RtcEngine rtcEngine, {
    required int viewId,
    required int userId,
  });

  Future<Either<Failure, void>> startLocalPreview();

  Future<Either<Failure, void>> stopLocalPreview();
}

abstract final class RemoteVideoOpsRepository {
  AgoraVideoView createRemoteVideoView(
    RtcEngine rtcEngine, {
    required int viewId,
    required int userId,
    required String channelId,
  });
}

final class LocalVideoOpsRepositoryImplementation
    with RtcOperationHandler
    implements LocalVideoOpsRepository {
  const LocalVideoOpsRepositoryImplementation(
    RtcEngine rtcService,
  ) : _rtcService = rtcService;

  final RtcEngine _rtcService;

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
  const RemoteVideoOpsRepositoryImplementation();

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
}
