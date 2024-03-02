// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/repositories/video_ops_repository.dart'
    show LocalVideoOpsRepository;

part 'toggle_local_video_state.dart';

final class ToggleLocalVideoCubit extends Cubit<ToggleLocalVideoState> {
  ToggleLocalVideoCubit(
    LocalVideoOpsRepository localVideoOpsRepository,
  )   : _localVideoOpsRepository = localVideoOpsRepository,
        super(
          const ToggleLocalVideoInitialState(),
        );

  final LocalVideoOpsRepository _localVideoOpsRepository;

  Future<void> toggleLocalVideo({
    required bool to,
  }) async {
    emit(
      TogglingLocalVideoState(
        to,
      ),
    );

    final toggleLocalVideoResult = await switch (to) {
      true => _localVideoOpsRepository.enableLocalVideo(),
      false => _localVideoOpsRepository.disableLocalVideo(),
    };

    toggleLocalVideoResult.fold(
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
        FailedToToggleLocalVideoState(
          to: to,
          failure: failure,
        ),
      );

  void _success(
    bool to,
  ) =>
      emit(
        ToggledLocalVideoState(
          to,
        ),
      );
}
