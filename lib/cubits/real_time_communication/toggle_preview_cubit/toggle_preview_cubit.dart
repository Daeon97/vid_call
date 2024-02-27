// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/repositories/video_ops_repository.dart'
    show VideoOpsRepository;

part 'toggle_preview_state.dart';

final class TogglePreviewCubit extends Cubit<TogglePreviewState> {
  TogglePreviewCubit(
    VideoOpsRepository videoOpsRepository,
  )   : _videoOpsRepository = videoOpsRepository,
        super(
          const TogglePreviewInitialState(),
        );

  final VideoOpsRepository _videoOpsRepository;

  Future<void> togglePreview({
    required bool enable,
  }) async {
    emit(
      const TogglingPreviewState(),
    );

    final togglePreviewResult = await switch (enable) {
      true => _videoOpsRepository.startPreview(),
      false => _videoOpsRepository.stopPreview(),
    };

    togglePreviewResult.fold(
      _failure,
      _success,
    );
  }

  void _failure(
    Failure failure,
  ) =>
      emit(
        FailedToTogglePreviewState(
          failure,
        ),
      );

  void _success(
    void _,
  ) =>
      emit(
        const ToggledPreviewState(),
      );
}
