// ignore_for_file: public_member_api_docs

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:dartz/dartz.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/utils/clients/rtc_operation_handler.dart';

abstract interface class AudioOpsRepository
    with _LocalAudioOpsRepository, _RemoteAudioOpsRepository {
  Future<Either<Failure, void>> enableAudio();

  Future<Either<Failure, void>> disableAudio();
}

abstract mixin class _LocalAudioOpsRepository {
  Future<Either<Failure, void>> enableLocalAudio();

  Future<Either<Failure, void>> disableLocalAudio();

  Future<Either<Failure, void>> muteLocalAudioStream();

  Future<Either<Failure, void>> unMuteLocalAudioStream();
}

abstract mixin class _RemoteAudioOpsRepository {
  Future<Either<Failure, void>> muteRemoteAudioStream(
    int userId,
  );

  Future<Either<Failure, void>> unMuteRemoteAudioStream(
    int userId,
  );

  Future<Either<Failure, void>> muteAllRemoteAudioStreams();

  Future<Either<Failure, void>> unMuteAllRemoteAudioStreams();
}

/* TODO(Daeon97): Modify this implementation to pass calls to a
    util class that can catch and handle errors thrown from Agora */
final class AudioOpsRepositoryImplementation
    with RtcOperationHandler
    implements AudioOpsRepository {
  const AudioOpsRepositoryImplementation(
    RtcEngine rtcService,
  ) : _rtcService = rtcService;

  final RtcEngine _rtcService;

  @override
  Future<Either<Failure, void>> enableLocalAudio() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.enableLocalAudio(
          true,
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> disableLocalAudio() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.enableLocalAudio(
          false,
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> muteLocalAudioStream() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.muteLocalAudioStream(
          true,
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> unMuteLocalAudioStream() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.muteLocalAudioStream(
          false,
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> enableAudio() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: _rtcService.enableAudio,
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> disableAudio() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: _rtcService.disableAudio,
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> muteRemoteAudioStream(
    int userId,
  ) =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.muteRemoteAudioStream(
          uid: userId,
          mute: true,
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> unMuteRemoteAudioStream(
    int userId,
  ) =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.muteRemoteAudioStream(
          uid: userId,
          mute: false,
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> muteAllRemoteAudioStreams() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.muteAllRemoteAudioStreams(
          true,
        ),
        failureHandler: Failure.new,
      );

  @override
  Future<Either<Failure, void>> unMuteAllRemoteAudioStreams() =>
      handleRtcOperation<Failure, void>(
        rtcOperationInitiator: () => _rtcService.muteAllRemoteAudioStreams(
          false,
        ),
        failureHandler: Failure.new,
      );
}
