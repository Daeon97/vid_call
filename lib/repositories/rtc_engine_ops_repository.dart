// ignore_for_file: public_member_api_docs

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:dartz/dartz.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/resources/strings/ui.dart'
    show failedToInitializeRtcEngine, failedToRegisterEventHandler;
import 'package:vid_call/utils/clients/rtc_operation_handler.dart';

abstract final class RtcEngineOpsRepository {
  Future<Either<Failure, void>> initialize(
    String appId,
  );

  Future<Either<Failure, void>> registerEventHandler(
    RtcEngineEventHandler eventHandler,
  );
}

final class RtcEngineOpsRepositoryImplementation
    with RtcOperationHandler
    implements RtcEngineOpsRepository {
  const RtcEngineOpsRepositoryImplementation(
    RtcEngine rtcService,
  ) : _rtcService = rtcService;

  final RtcEngine _rtcService;

  @override
  Future<Either<Failure, void>> initialize(
    String appId,
  ) =>
      handleRtcOperation<void>(
        rtcOperationInitiator: () => _rtcService.initialize(
          RtcEngineContext(
            appId: appId,
            channelProfile: ChannelProfileType.channelProfileCommunication,
          ),
        ),
        failureMessage: failedToInitializeRtcEngine,
      );

  @override
  Future<Either<Failure, void>> registerEventHandler(
    RtcEngineEventHandler eventHandler,
  ) =>
      handleRtcOperation<void>(
        rtcOperationInitiator: () async => _rtcService.registerEventHandler(
          eventHandler,
        ),
        failureMessage: failedToRegisterEventHandler,
      );
}
