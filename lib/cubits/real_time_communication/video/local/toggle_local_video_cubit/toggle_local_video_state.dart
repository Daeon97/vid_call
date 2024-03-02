// ignore_for_file: public_member_api_docs, avoid_positional_boolean_parameters

part of 'toggle_local_video_cubit.dart';

abstract final class ToggleLocalVideoState extends Equatable {
  const ToggleLocalVideoState();
}

final class ToggleLocalVideoInitialState extends ToggleLocalVideoState {
  const ToggleLocalVideoInitialState();

  @override
  List<Object?> get props => [];
}

final class TogglingLocalVideoState extends ToggleLocalVideoState {
  const TogglingLocalVideoState(
    this.to,
  );

  final bool to;

  @override
  List<Object?> get props => [
        to,
      ];
}

final class ToggledLocalVideoState extends ToggleLocalVideoState {
  const ToggledLocalVideoState(
    this.to,
  );

  final bool to;

  @override
  List<Object?> get props => [
        to,
      ];
}

final class FailedToToggleLocalVideoState extends ToggleLocalVideoState {
  const FailedToToggleLocalVideoState({
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
