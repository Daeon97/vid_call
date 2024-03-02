// ignore_for_file: public_member_api_docs, avoid_positional_boolean_parameters

part of 'toggle_local_preview_cubit.dart';

abstract final class ToggleLocalPreviewState extends Equatable {
  const ToggleLocalPreviewState();
}

final class ToggleLocalPreviewInitialState extends ToggleLocalPreviewState {
  const ToggleLocalPreviewInitialState();

  @override
  List<Object?> get props => [];
}

final class TogglingLocalPreviewState extends ToggleLocalPreviewState {
  const TogglingLocalPreviewState(
    this.to,
  );

  final bool to;

  @override
  List<Object?> get props => [
        to,
      ];
}

final class ToggledLocalPreviewState extends ToggleLocalPreviewState {
  const ToggledLocalPreviewState(
    this.to,
  );

  final bool to;

  @override
  List<Object?> get props => [
        to,
      ];
}

final class FailedToToggleLocalPreviewState extends ToggleLocalPreviewState {
  const FailedToToggleLocalPreviewState({
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
