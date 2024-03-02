// ignore_for_file: public_member_api_docs

part of 'initialize_real_time_communication_cubit.dart';

abstract final class InitializeRealTimeCommunicationState extends Equatable {
  const InitializeRealTimeCommunicationState();
}

final class InitializeRealTimeCommunicationInitialState
    extends InitializeRealTimeCommunicationState {
  const InitializeRealTimeCommunicationInitialState();

  @override
  List<Object?> get props => [];
}

final class InitializingRealTimeCommunicationState
    extends InitializeRealTimeCommunicationState {
  const InitializingRealTimeCommunicationState();

  @override
  List<Object?> get props => [];
}

final class InitializedRealTimeCommunicationState
    extends InitializeRealTimeCommunicationState {
  const InitializedRealTimeCommunicationState();

  @override
  List<Object?> get props => [];
}

final class FailedToInitializeRealTimeCommunicationState
    extends InitializeRealTimeCommunicationState {
  const FailedToInitializeRealTimeCommunicationState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
