// ignore_for_file: public_member_api_docs, avoid_positional_boolean_parameters

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
  const TogglingAudioState(
    this.to,
  );

  final bool to;

  @override
  List<Object?> get props => [
        to,
      ];
}

final class ToggledAudioState extends ToggleAudioState {
  const ToggledAudioState(
    this.to,
  );

  final bool to;

  @override
  List<Object?> get props => [
        to,
      ];
}

final class FailedToToggleAudioState extends ToggleAudioState {
  const FailedToToggleAudioState({
    required this.to,
    required this.failure,
  });

  final bool to;
  final Failure failure;

  @override
  List<Object?> get props => [
        to,
        failure,
      ];
}
