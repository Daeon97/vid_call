// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/repositories/channel_ops_repository.dart'
    show ChannelOpsRepository;
import 'package:vid_call/resources/numbers/constants.dart' show nil;
import 'package:vid_call/resources/strings/environment.dart'
    show testChannelId, testChannelTemporaryToken;

part 'join_channel_state.dart';

class JoinChannelCubit extends Cubit<JoinChannelState> {
  JoinChannelCubit(
    ChannelOpsRepository channelOpsRepository,
  )   : _channelOpsRepository = channelOpsRepository,
        super(
          const JoinChannelInitialState(),
        );

  final ChannelOpsRepository _channelOpsRepository;

  Future<void> joinChannel(// required String token,
      // required String channelId,
      // required int userId,
      ) async {
    emit(
      const JoiningChannelState(),
    );

    final joinChannelResult = await _channelOpsRepository.joinChannel(
      token: dotenv.env[testChannelTemporaryToken]!,
      channelId: dotenv.env[testChannelId]!,
      userId: nil,
    );

    joinChannelResult.fold(
      _failure,
      _success,
    );
  }

  void _failure(
    Failure failure,
  ) =>
      emit(
        FailedToJoinChannelState(
          failure,
        ),
      );

  void _success(
    void _,
  ) =>
      emit(
        const JoinedChannelState(),
      );
}
