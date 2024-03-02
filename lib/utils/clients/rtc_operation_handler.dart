// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/utils/type_definitions.dart'
    show RtcOperationInitiatorCallback;

mixin class RtcOperationHandler {
  Future<Either<Failure, R>> handleRtcOperation<R>({
    required RtcOperationInitiatorCallback<R> rtcOperationInitiator,
    required String failureMessage,
  }) async {
    try {
      final rtcOperation = await rtcOperationInitiator();

      return Right(
        rtcOperation,
      );
    } catch (error) {
      return Left(
        Failure(
          failureMessage,
        ),
      );
    }
  }
}
