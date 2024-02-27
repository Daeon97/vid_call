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
    required bool enable,
  }) async {
    emit(
      const TogglingAudioState(),
    );

    final toggleAudioResult = await switch (enable) {
      true => _audioOpsRepository.enableAudio(),
      false => _audioOpsRepository.disableAudio(),
    };

    toggleAudioResult.fold(
      _failure,
      _success,
    );
  }

  void _failure(
    Failure failure,
  ) =>
      emit(
        FailedToToggleAudioState(
          failure,
        ),
      );

  void _success(
    void _,
  ) =>
      emit(
        const ToggledAudioState(),
      );
}
