// ignore_for_file: public_member_api_docs, avoid_positional_boolean_parameters

part of 'toggle_video_cubit.dart';

abstract final class ToggleVideoState extends Equatable {
  const ToggleVideoState();
}

final class ToggleVideoInitialState extends ToggleVideoState {
  const ToggleVideoInitialState();

  @override
  List<Object?> get props => [];
}

final class TogglingVideoState extends ToggleVideoState {
  const TogglingVideoState(
    this.to,
  );

  final bool to;

  @override
  List<Object?> get props => [
        to,
      ];
}

final class ToggledVideoState extends ToggleVideoState {
  const ToggledVideoState(
    this.to,
  );

  final bool to;

  @override
  List<Object?> get props => [
        to,
      ];
}

final class FailedToToggleVideoState extends ToggleVideoState {
  const FailedToToggleVideoState({
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
