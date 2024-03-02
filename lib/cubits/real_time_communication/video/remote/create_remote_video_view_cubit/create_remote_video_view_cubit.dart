// ignore_for_file: public_member_api_docs

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vid_call/repositories/video_ops_repository.dart'
    show RemoteVideoOpsRepository;
import 'package:vid_call/resources/strings/environment.dart' show testChannelId;

part 'create_remote_video_view_state.dart';

final class CreateRemoteVideoViewCubit
    extends Cubit<CreateRemoteVideoViewState> {
  CreateRemoteVideoViewCubit({
    required RtcEngine rtcEngine,
    required RemoteVideoOpsRepository remoteVideoOpsRepository,
  })  : _rtcEngine = rtcEngine,
        _remoteVideoOpsRepository = remoteVideoOpsRepository,
        super(
          const CreateRemoteVideoViewInitialState(),
        );

  final RtcEngine _rtcEngine;
  final RemoteVideoOpsRepository _remoteVideoOpsRepository;

  void createRemoteVideoView(
    int remoteUserId,
  ) =>
      emit(
        CreatedRemoteVideoViewState(
          _remoteVideoOpsRepository.createRemoteVideoView(
            _rtcEngine,
            viewId: remoteUserId,
            userId: remoteUserId,
            channelId: dotenv.env[testChannelId]!,
          ),
        ),
      );
}
