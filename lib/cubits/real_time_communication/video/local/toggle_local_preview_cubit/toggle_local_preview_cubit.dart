// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/repositories/video_ops_repository.dart'
    show LocalVideoOpsRepository;

part 'toggle_local_preview_state.dart';

final class ToggleLocalPreviewCubit extends Cubit<ToggleLocalPreviewState> {
  ToggleLocalPreviewCubit(
    LocalVideoOpsRepository localVideoOpsRepository,
  )   : _localVideoOpsRepository = localVideoOpsRepository,
        super(
          const ToggleLocalPreviewInitialState(),
        );

  final LocalVideoOpsRepository _localVideoOpsRepository;

  Future<void> toggleLocalPreview({
    required bool to,
  }) async {
    emit(
      TogglingLocalPreviewState(
        to,
      ),
    );

    final toggleLocalPreviewResult = await switch (to) {
      true => _localVideoOpsRepository.startLocalPreview(),
      false => _localVideoOpsRepository.stopLocalPreview(),
    };

    toggleLocalPreviewResult.fold(
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
        FailedToToggleLocalPreviewState(
          to: to,
          failure: failure,
        ),
      );

  void _success(
    bool to,
  ) =>
      emit(
        ToggledLocalPreviewState(
          to,
        ),
      );
}
