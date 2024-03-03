// ignore_for_file: public_member_api_docs

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:dartz/dartz.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/resources/strings/ui.dart'
    show failedToDisableLocalAudio, failedToEnableLocalAudio;
import 'package:vid_call/utils/clients/rtc_operation_handler.dart';

abstract final class LocalAudioOpsRepository {
  Future<Either<Failure, void>> enableLocalAudio();

  Future<Either<Failure, void>> disableLocalAudio();
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
}
