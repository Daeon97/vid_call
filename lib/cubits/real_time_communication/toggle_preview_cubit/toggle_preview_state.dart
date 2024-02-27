// ignore_for_file: public_member_api_docs

part of 'toggle_preview_cubit.dart';

abstract final class TogglePreviewState extends Equatable {
  const TogglePreviewState();
}

final class TogglePreviewInitialState extends TogglePreviewState {
  const TogglePreviewInitialState();

  @override
  List<Object?> get props => [];
}

final class TogglingPreviewState extends TogglePreviewState {
  const TogglingPreviewState();

  @override
  List<Object?> get props => [];
}

final class ToggledPreviewState extends TogglePreviewState {
  const ToggledPreviewState();

  @override
  List<Object?> get props => [];
}

final class FailedToTogglePreviewState extends TogglePreviewState {
  const FailedToTogglePreviewState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
