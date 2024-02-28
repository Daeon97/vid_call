// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/repositories/audio_ops_repository.dart'
    show AudioOpsRepository;

part 'toggle_audio_state.dart';

final class ToggleAudioCubit extends Cubit<ToggleAudioState> {
  ToggleAudioCubit(
    AudioOpsRepository audioOpsRepository,
  )   : _audioOpsRepository = audioOpsRepository,
        super(
          const ToggleAudioInitialState(),
        );

  final AudioOpsRepository _audioOpsRepository;

  Future<void> toggleAudio({
    required bool to,
  }) async {
    emit(
      TogglingAudioState(
        to,
      ),
    );

    final toggleAudioResult = await switch (to) {
      true => _audioOpsRepository.enableAudio(),
      false => _audioOpsRepository.disableAudio(),
    };

    toggleAudioResult.fold(
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
        FailedToToggleAudioState(
          to: to,
          failure: failure,
        ),
      );

  void _success(
    bool to,
  ) =>
      emit(
        ToggledAudioState(
          to,
        ),
      );
}
