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
    required bool to,
  }) async {
    emit(
      TogglingVideoState(
        to,
      ),
    );

    final toggleVideoResult = await switch (to) {
      true => _videoOpsRepository.enableVideo(),
      false => _videoOpsRepository.disableVideo(),
    };

    toggleVideoResult.fold(
      (failure) => _failure(
        to: to,
        failure: failure,
      ),
      (_) => _success(
        to,
      ),
    );
  }

  void _failure({
    required bool to,
    required Failure failure,
  }) =>
      emit(
        FailedToToggleVideoState(
          to: to,
          failure: failure,
        ),
      );

  void _success(
    bool to,
  ) =>
      emit(
        ToggledVideoState(
          to,
        ),
      );
}
