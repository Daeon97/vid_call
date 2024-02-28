// ignore_for_file: public_member_api_docs, avoid_positional_boolean_parameters

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
  const TogglingPreviewState(
    this.to,
  );

  final bool to;

  @override
  List<Object?> get props => [
        to,
      ];
}

final class ToggledPreviewState extends TogglePreviewState {
  const ToggledPreviewState(
    this.to,
  );

  final bool to;

  @override
  List<Object?> get props => [
        to,
      ];
}

final class FailedToTogglePreviewState extends TogglePreviewState {
  const FailedToTogglePreviewState({
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
