// ignore_for_file: public_member_api_docs

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vid_call/injection_container.dart' show sl;
import 'package:vid_call/repositories/video_ops_repository.dart'
    show VideoOpsRepository;
import 'package:vid_call/utils/type_definitions.dart'
    show OnVideoViewCreatedCallback;

part 'create_remote_video_view_state.dart';

final class CreateRemoteVideoViewCubit
    extends Cubit<CreateRemoteVideoViewState> {
  CreateRemoteVideoViewCubit(
    VideoOpsRepository videoOpsRepository,
  )   : _videoOpsRepository = videoOpsRepository,
        super(
          const CreateRemoteVideoViewInitialState(),
        );

  final VideoOpsRepository _videoOpsRepository;

  void createRemoteVideoView(
    int remoteUserId,
  ) =>
      emit(
        CreatedRemoteVideoViewState(
          _videoOpsRepository.createVideoView(
            sl<RtcEngine>(),
            viewId: remoteUserId,
            userId: remoteUserId,
            onVideoViewCreated: (id) {
              print('Remote user view ID is $id');
            },
          ),
        ),
      );
}
