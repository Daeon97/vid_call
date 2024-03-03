// ignore_for_file: public_member_api_docs

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vid_call/repositories/video_ops_repository.dart'
    show LocalVideoOpsRepository;
import 'package:vid_call/resources/numbers/constants.dart' show nil;

part 'create_local_video_view_state.dart';

final class CreateLocalVideoViewCubit extends Cubit<CreateLocalVideoViewState> {
  CreateLocalVideoViewCubit({
    required RtcEngine rtcEngine,
    required LocalVideoOpsRepository localVideoOpsRepository,
  })  : _rtcEngine = rtcEngine,
        _localVideoOpsRepository = localVideoOpsRepository,
        super(
          const CreateLocalVideoViewInitialState(),
        );

  final RtcEngine _rtcEngine;
  final LocalVideoOpsRepository _localVideoOpsRepository;

  void createLocalVideoView() => emit(
        CreatedLocalVideoViewState(
          _localVideoOpsRepository.createLocalVideoView(
            _rtcEngine,
            viewId: nil,
            userId: nil,
          ),
        ),
      );
}
