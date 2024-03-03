// ignore_for_file: public_member_api_docs

part of 'real_time_communication_event_cubit.dart';

abstract final class RealTimeCommunicationEventState extends Equatable {
  const RealTimeCommunicationEventState();
}

final class RealTimeCommunicationEventInitialState
    extends RealTimeCommunicationEventState {
  const RealTimeCommunicationEventInitialState();

  @override
  List<Object?> get props => [];
}

final class WaitingToListenRealTimeCommunicationEventState
    extends RealTimeCommunicationEventState {
  const WaitingToListenRealTimeCommunicationEventState();

  @override
  List<Object?> get props => [];
}

final class ListeningRealTimeCommunicationEventState
    extends RealTimeCommunicationEventState {
  const ListeningRealTimeCommunicationEventState();

  @override
  List<Object?> get props => [];
}

final class FailedToListenRealTimeCommunicationEventState
    extends RealTimeCommunicationEventState {
  const FailedToListenRealTimeCommunicationEventState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}

final class ErrorState extends RealTimeCommunicationEventState {
  const ErrorState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}

final class ChannelJoinedState extends RealTimeCommunicationEventState {
  const ChannelJoinedState();

  @override
  List<Object?> get props => [];
}

final class RemoteUserJoinedState extends RealTimeCommunicationEventState {
  const RemoteUserJoinedState({
    required this.remoteUserId,
    required this.elapsed,
  });

  final int remoteUserId;
  final int elapsed;

  @override
  List<Object?> get props => [
        remoteUserId,
        elapsed,
      ];
}

final class RemoteUserLeftState extends RealTimeCommunicationEventState {
  const RemoteUserLeftState({
    required this.remoteUserId,
    required this.failure,
  });

  final int remoteUserId;
  final Failure failure;

  @override
  List<Object?> get props => [
        remoteUserId,
        failure,
      ];
}

final class RemoteUserEnabledLocalVideoState
    extends RealTimeCommunicationEventState {
  const RemoteUserEnabledLocalVideoState(
    this.remoteUserId,
  );

  final int remoteUserId;

  @override
  List<Object?> get props => [
        remoteUserId,
      ];
}

final class RemoteUserDisabledLocalVideoState
    extends RealTimeCommunicationEventState {
  const RemoteUserDisabledLocalVideoState(
    this.remoteUserId,
  );

  final int remoteUserId;

  @override
  List<Object?> get props => [
        remoteUserId,
      ];
}

final class WaitingToStopListeningRealTimeCommunicationEventState
    extends RealTimeCommunicationEventState {
  const WaitingToStopListeningRealTimeCommunicationEventState();

  @override
  List<Object?> get props => [];
}

final class StoppedListeningRealTimeCommunicationEventState
    extends RealTimeCommunicationEventState {
  const StoppedListeningRealTimeCommunicationEventState();

  @override
  List<Object?> get props => [];
}

final class FailedToStopListeningRealTimeCommunicationEventState
    extends RealTimeCommunicationEventState {
  const FailedToStopListeningRealTimeCommunicationEventState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
