// ignore_for_file: public_member_api_docs

part of 'join_channel_cubit.dart';

abstract final class JoinChannelState extends Equatable {
  const JoinChannelState();
}

final class JoinChannelInitialState extends JoinChannelState {
  const JoinChannelInitialState();

  @override
  List<Object?> get props => [];
}

final class JoiningChannelState extends JoinChannelState {
  const JoiningChannelState();

  @override
  List<Object?> get props => [];
}

final class JoinedChannelState extends JoinChannelState {
  const JoinedChannelState();

  @override
  List<Object?> get props => [];
}

final class FailedToJoinChannelState extends JoinChannelState {
  const FailedToJoinChannelState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
