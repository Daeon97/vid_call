// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/repositories/video_ops_repository.dart'
    show VideoOpsRepository;

part 'toggle_video_state.dart';

final class ToggleVideoCubit extends Cubit<ToggleVideoState> {
  ToggleVideoCubit(
    VideoOpsRepository videoOpsRepository,
  )   : _videoOpsRepository = videoOpsRepository,
        super(
          const ToggleVideoInitialState(),
        );

  final VideoOpsRepository _videoOpsRepository;

  Future<void> toggleVideo({
    required bool enable,
  }) async {
    emit(
      const TogglingVideoState(),
    );

    final toggleVideoResult = await switch (enable) {
      true => _videoOpsRepository.enableVideo(),
      false => _videoOpsRepository.disableVideo(),
    };

    toggleVideoResult.fold(
      _failure,
      _success,
    );
  }

  void _failure(
    Failure failure,
  ) =>
      emit(
        FailedToToggleVideoState(
          failure,
        ),
      );

  void _success(
    void _,
  ) =>
      emit(
        const ToggledVideoState(),
      );
}
