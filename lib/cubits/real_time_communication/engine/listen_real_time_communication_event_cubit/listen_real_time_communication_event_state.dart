// ignore_for_file: public_member_api_docs

part of 'listen_real_time_communication_event_cubit.dart';

abstract final class ListenRealTimeCommunicationEventState extends Equatable {
  const ListenRealTimeCommunicationEventState();
}

final class ListenRealTimeCommunicationEventInitialState
    extends ListenRealTimeCommunicationEventState {
  const ListenRealTimeCommunicationEventInitialState();

  @override
  List<Object?> get props => [];
}

final class WaitingToListenRealTimeCommunicationEventState
    extends ListenRealTimeCommunicationEventState {
  const WaitingToListenRealTimeCommunicationEventState();

  @override
  List<Object?> get props => [];
}

final class ListeningRealTimeCommunicationEventState
    extends ListenRealTimeCommunicationEventState {
  const ListeningRealTimeCommunicationEventState();

  @override
  List<Object?> get props => [];
}

final class FailedToListenRealTimeCommunicationEventState
    extends ListenRealTimeCommunicationEventState {
  const FailedToListenRealTimeCommunicationEventState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}

final class ChannelJoinedState extends ListenRealTimeCommunicationEventState {
  const ChannelJoinedState();

  @override
  List<Object?> get props => [];
}

final class RemoteUserJoinedState
    extends ListenRealTimeCommunicationEventState {
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

final class RemoteUserLeftState extends ListenRealTimeCommunicationEventState {
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
