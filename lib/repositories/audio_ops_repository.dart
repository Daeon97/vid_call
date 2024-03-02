// ignore_for_file: public_member_api_docs

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:dartz/dartz.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/resources/strings/ui.dart'
    show
        failedToDisableLocalAudio,
        failedToEnableLocalAudio,
        failedToMuteAllRemoteAudioStreams,
        failedToMuteLocalAudioStream,
        failedToMuteRemoteAudioStream,
        failedToUnMuteAllRemoteAudioStreams,
        failedToUnMuteLocalAudioStream,
        failedToUnMuteRemoteAudioStream;
import 'package:vid_call/utils/clients/rtc_operation_handler.dart';

abstract final class LocalAudioOpsRepository {
  Future<Either<Failure, void>> enableLocalAudio();

  Future<Either<Failure, void>> disableLocalAudio();

  Future<Either<Failure, void>> muteLocalAudioStream();

  Future<Either<Failure, void>> unMuteLocalAudioStream();
}

abstract final class RemoteAudioOpsRepository {
  Future<Either<Failure, void>> muteRemoteAudioStream(
    int userId,
  );

  Future<Either<Failure, void>> unMuteRemoteAudioStream(
    int userId,
  );

  Future<Either<Failure, void>> muteAllRemoteAudioStreams();

  Future<Either<Failure, void>> unMuteAllRemoteAudioStreams();
}

final class LocalAudioOpsRepositoryImplementation
    with RtcOperationHandler
    implements LocalAudioOpsRepository {
  const LocalAudioOpsRepositoryImplementation(
    RtcEngine rtcService,
  ) : _rtcService = rtcService;

  final RtcEngine _rtcService;

  @override
  Future<Either<Failure, void>> enableLocalAudio() => handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.enableLocalAudio(
          true,
        ),
        failureMessage: failedToEnableLocalAudio,
      );

  @override
  Future<Either<Failure, void>> disableLocalAudio() => handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.enableLocalAudio(
          false,
        ),
        failureMessage: failedToDisableLocalAudio,
      );

  @override
  Future<Either<Failure, void>> muteLocalAudioStream() =>
      handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.muteLocalAudioStream(
          true,
        ),
        failureMessage: failedToMuteLocalAudioStream,
      );

  @override
  Future<Either<Failure, void>> unMuteLocalAudioStream() =>
      handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.muteLocalAudioStream(
          false,
        ),
        failureMessage: failedToUnMuteLocalAudioStream,
      );
}

final class RemoteAudioOpsRepositoryImplementation
    with RtcOperationHandler
    implements RemoteAudioOpsRepository {
  const RemoteAudioOpsRepositoryImplementation(
    RtcEngine rtcService,
  ) : _rtcService = rtcService;

  final RtcEngine _rtcService;

  @override
  Future<Either<Failure, void>> muteRemoteAudioStream(
    int userId,
  ) =>
      handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.muteRemoteAudioStream(
          uid: userId,
          mute: true,
        ),
        failureMessage: failedToMuteRemoteAudioStream,
      );

  @override
  Future<Either<Failure, void>> unMuteRemoteAudioStream(
    int userId,
  ) =>
      handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.muteRemoteAudioStream(
          uid: userId,
          mute: false,
        ),
        failureMessage: failedToUnMuteRemoteAudioStream,
      );

  @override
  Future<Either<Failure, void>> muteAllRemoteAudioStreams() =>
      handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.muteAllRemoteAudioStreams(
          true,
        ),
        failureMessage: failedToMuteAllRemoteAudioStreams,
      );

  @override
  Future<Either<Failure, void>> unMuteAllRemoteAudioStreams() =>
      handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.muteAllRemoteAudioStreams(
          false,
        ),
        failureMessage: failedToUnMuteAllRemoteAudioStreams,
      );
}
