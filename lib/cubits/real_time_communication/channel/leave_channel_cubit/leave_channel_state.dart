// ignore_for_file: public_member_api_docs

part of 'leave_channel_cubit.dart';

abstract final class LeaveChannelState extends Equatable {
  const LeaveChannelState();
}

final class LeaveChannelInitialState extends LeaveChannelState {
  const LeaveChannelInitialState();

  @override
  List<Object?> get props => [];
}

final class LeavingChannelState extends LeaveChannelState {
  const LeavingChannelState();

  @override
  List<Object?> get props => [];
}

final class LeftChannelState extends LeaveChannelState {
  const LeftChannelState();

  @override
  List<Object?> get props => [];
}

final class FailedToLeaveChannelState extends LeaveChannelState {
  const FailedToLeaveChannelState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
