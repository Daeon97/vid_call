// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/repositories/channel_ops_repository.dart'
    show ChannelOpsRepository;

part 'leave_channel_state.dart';

class LeaveChannelCubit extends Cubit<LeaveChannelState> {
  LeaveChannelCubit(
    ChannelOpsRepository channelOpsRepository,
  )   : _channelOpsRepository = channelOpsRepository,
        super(
          const LeaveChannelInitialState(),
        );

  final ChannelOpsRepository _channelOpsRepository;

  Future<void> leaveChannel() async {
    emit(
      const LeavingChannelState(),
    );

    final leaveChannelResult = await _channelOpsRepository.leaveChannel();

    leaveChannelResult.fold(
      _failure,
      _success,
    );
  }

  void _failure(
    Failure failure,
  ) =>
      emit(
        FailedToLeaveChannelState(
          failure,
        ),
      );

  void _success(
    void _,
  ) =>
      emit(
        const LeftChannelState(),
      );
}
