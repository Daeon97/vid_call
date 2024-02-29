// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/repositories/video_ops_repository.dart'
    show VideoOpsRepository;
import 'package:vid_call/resources/strings/environment.dart';
import 'package:vid_call/utils/enums.dart' show Role;

part 'join_channel_state.dart';

class JoinChannelCubit extends Cubit<JoinChannelState> {
  JoinChannelCubit(
    VideoOpsRepository videoOpsRepository,
  )   : _videoOpsRepository = videoOpsRepository,
        super(
          const JoinChannelInitialState(),
        );

  final VideoOpsRepository _videoOpsRepository;

  Future<void> joinChannel({
    // required String token,
    // required String channelId,
    required int userId,
    required Role role,
  }) async {
    emit(
      const JoiningChannelState(),
    );

    final joinChannelResult = await _videoOpsRepository.joinChannel(
      token: dotenv.env[testChannelTemporaryToken]!,
      channelId: dotenv.env[testChannelId]!,
      userId: userId,
      role: role,
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
