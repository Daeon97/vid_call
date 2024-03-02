// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/repositories/rtc_engine_ops_repository.dart'
    show RtcEngineOpsRepository;

part 'initialize_real_time_communication_state.dart';

final class InitializeRealTimeCommunicationCubit
    extends Cubit<InitializeRealTimeCommunicationState> {
  InitializeRealTimeCommunicationCubit({
    required String appId,
    required RtcEngineOpsRepository rtcEngineOpsRepository,
  })  : _appId = appId,
        _rtcEngineOpsRepository = rtcEngineOpsRepository,
        super(
          const InitializeRealTimeCommunicationInitialState(),
        );

  final String _appId;
  final RtcEngineOpsRepository _rtcEngineOpsRepository;

  Future<void> initializeRealTimeCommunication() async {
    emit(
      const InitializingRealTimeCommunicationState(),
    );

    final initializationResult = await _rtcEngineOpsRepository.initialize(
      _appId,
    );

    initializationResult.fold(
      _failure,
      _success,
    );
  }

  void _failure(
    Failure failure,
  ) =>
      emit(
        FailedToInitializeRealTimeCommunicationState(
          failure,
        ),
      );

  void _success(
    void _,
  ) =>
      emit(
        const InitializedRealTimeCommunicationState(),
      );
}
