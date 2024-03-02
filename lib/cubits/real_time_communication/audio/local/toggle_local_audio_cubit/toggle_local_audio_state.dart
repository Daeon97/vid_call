// ignore_for_file: public_member_api_docs, avoid_positional_boolean_parameters

part of 'toggle_local_audio_cubit.dart';

abstract final class ToggleLocalAudioState extends Equatable {
  const ToggleLocalAudioState();
}

final class ToggleLocalAudioInitialState extends ToggleLocalAudioState {
  const ToggleLocalAudioInitialState();

  @override
  List<Object?> get props => [];
}

final class TogglingLocalAudioState extends ToggleLocalAudioState {
  const TogglingLocalAudioState(
    this.to,
  );

  final bool to;

  @override
  List<Object?> get props => [
        to,
      ];
}

final class ToggledLocalAudioState extends ToggleLocalAudioState {
  const ToggledLocalAudioState(
    this.to,
  );

  final bool to;

  @override
  List<Object?> get props => [
        to,
      ];
}

final class FailedToToggleLocalAudioState extends ToggleLocalAudioState {
  const FailedToToggleLocalAudioState({
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
