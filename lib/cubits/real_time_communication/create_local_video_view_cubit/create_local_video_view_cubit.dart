// ignore_for_file: public_member_api_docs

import 'dart:math';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vid_call/injection_container.dart' show sl;
import 'package:vid_call/repositories/video_ops_repository.dart'
    show VideoOpsRepository;
import 'package:vid_call/utils/type_definitions.dart'
    show OnVideoViewCreatedCallback;

part 'create_local_video_view_state.dart';

final class CreateLocalVideoViewCubit extends Cubit<CreateLocalVideoViewState> {
  CreateLocalVideoViewCubit(
    VideoOpsRepository videoOpsRepository,
  )   : _videoOpsRepository = videoOpsRepository,
        super(
          const CreateLocalVideoViewInitialState(),
        );

  final VideoOpsRepository _videoOpsRepository;

  void createLocalVideoView({
    required int id,
  }) =>
      emit(
        CreatedLocalVideoViewState(
          _videoOpsRepository.createVideoView(
            sl<RtcEngine>(),
            viewId: id,
            userId: id,
            onVideoViewCreated: (id) {
              print('Randomly generated ID is $id');
            },
          ),
        ),
      );
}
