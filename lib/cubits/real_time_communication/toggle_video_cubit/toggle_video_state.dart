// ignore_for_file: public_member_api_docs

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
  const TogglingVideoState();

  @override
  List<Object?> get props => [];
}

final class ToggledVideoState extends ToggleVideoState {
  const ToggledVideoState();

  @override
  List<Object?> get props => [];
}

final class FailedToToggleVideoState extends ToggleVideoState {
  const FailedToToggleVideoState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
