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
    required bool to,
  }) async {
    emit(
      TogglingPreviewState(
        to,
      ),
    );

    final togglePreviewResult = await switch (to) {
      true => _videoOpsRepository.startPreview(),
      false => _videoOpsRepository.stopPreview(),
    };

    togglePreviewResult.fold(
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
        FailedToTogglePreviewState(
          to: to,
          failure: failure,
        ),
      );

  void _success(
    bool to,
  ) =>
      emit(
        ToggledPreviewState(
          to,
        ),
      );
}
