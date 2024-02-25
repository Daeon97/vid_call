import 'package:dartz/dartz.dart';
import '../../resources/strings/ui.dart' show theOperationFailed;
import '../type_definitions.dart'
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
