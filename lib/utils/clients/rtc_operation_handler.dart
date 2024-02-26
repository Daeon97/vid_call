// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:vid_call/resources/strings/ui.dart' show theOperationFailed;
import 'package:vid_call/utils/type_definitions.dart'
    show FailureHandlerCallback, RtcOperationInitiatorCallback;

mixin class RtcOperationHandler {
  Future<Either<L, R>> handleRtcOperation<L, R>({
    required RtcOperationInitiatorCallback<R> rtcOperationInitiator,
    required FailureHandlerCallback<L> failureHandler,
  }) async {
    try {
      final rtcOperation = await rtcOperationInitiator();

      return Right(
        rtcOperation,
      );
    } catch (error) {
      return Left(
        failureHandler(
          theOperationFailed,
        ),
      );
    }
  }
}
