// ignore_for_file: public_member_api_docs

part of 'toggle_audio_cubit.dart';

abstract final class ToggleAudioState extends Equatable {
  const ToggleAudioState();
}

final class ToggleAudioInitialState extends ToggleAudioState {
  const ToggleAudioInitialState();

  @override
  List<Object?> get props => [];
}

final class TogglingAudioState extends ToggleAudioState {
  const TogglingAudioState();

  @override
  List<Object?> get props => [];
}

final class ToggledAudioState extends ToggleAudioState {
  const ToggledAudioState();

  @override
  List<Object?> get props => [];
}

final class FailedToToggleAudioState extends ToggleAudioState {
  const FailedToToggleAudioState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
