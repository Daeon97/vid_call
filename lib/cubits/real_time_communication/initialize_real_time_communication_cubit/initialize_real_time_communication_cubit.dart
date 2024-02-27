// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/repositories/video_ops_repository.dart'
    show VideoOpsRepository;
import 'package:vid_call/resources/strings/environment.dart' show appId;

part 'initialize_real_time_communication_state.dart';

final class InitializeRealTimeCommunicationCubit
    extends Cubit<InitializeRealTimeCommunicationState> {
  InitializeRealTimeCommunicationCubit(
    VideoOpsRepository videoOpsRepository,
  )   : _videoOpsRepository = videoOpsRepository,
        super(
          const InitializeRealTimeCommunicationInitialState(),
        );

  final VideoOpsRepository _videoOpsRepository;

  Future<void> initializeRealTimeCommunication() async {
    emit(
      const InitializingRealTimeCommunicationState(),
    );

    final initializationResult = await _videoOpsRepository.initialize(
      dotenv.env[appId]!,
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
