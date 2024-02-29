// ignore_for_file: public_member_api_docs

part of 'listen_remote_user_cubit.dart';

abstract final class ListenRemoteUserState extends Equatable {
  const ListenRemoteUserState();
}

final class ListenRemoteUserInitialState extends ListenRemoteUserState {
  const ListenRemoteUserInitialState();

  @override
  List<Object?> get props => [];
}

final class ListenRemoteUserSuccessState extends ListenRemoteUserState {
  const ListenRemoteUserSuccessState();

  @override
  List<Object?> get props => [];
}

final class WaitingForRemoteUserState extends ListenRemoteUserState {
  const WaitingForRemoteUserState();

  @override
  List<Object?> get props => [];
}

final class RemoteUserJoinedState extends ListenRemoteUserState {
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

final class RemoteUserLeftState extends ListenRemoteUserState {
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

final class ListenRemoteUserFailedState extends ListenRemoteUserState {
  const ListenRemoteUserFailedState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
