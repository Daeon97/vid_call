// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/repositories/audio_ops_repository.dart'
    show LocalAudioOpsRepository;

part 'toggle_local_audio_state.dart';

final class ToggleLocalAudioCubit extends Cubit<ToggleLocalAudioState> {
  ToggleLocalAudioCubit(
    LocalAudioOpsRepository localAudioOpsRepository,
  )   : _localAudioOpsRepository = localAudioOpsRepository,
        super(
          const ToggleLocalAudioInitialState(),
        );

  final LocalAudioOpsRepository _localAudioOpsRepository;

  Future<void> toggleLocalAudio({
    required bool to,
  }) async {
    emit(
      TogglingLocalAudioState(
        to,
      ),
    );

    final toggleLocalAudioResult = await switch (to) {
      true => _localAudioOpsRepository.enableLocalAudio(),
      false => _localAudioOpsRepository.disableLocalAudio(),
    };

    toggleLocalAudioResult.fold(
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
        FailedToToggleLocalAudioState(
          to: to,
          failure: failure,
        ),
      );

  void _success(
    bool to,
  ) =>
      emit(
        ToggledLocalAudioState(
          to,
        ),
      );
}
