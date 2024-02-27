// ignore_for_file: public_member_api_docs

part of 'open_permission_settings_cubit.dart';

abstract final class OpenPermissionSettingsState extends Equatable {
  const OpenPermissionSettingsState();
}

final class OpenPermissionSettingsInitialState
    extends OpenPermissionSettingsState {
  const OpenPermissionSettingsInitialState();

  @override
  List<Object?> get props => [];
}

final class OpeningPermissionSettingsState extends OpenPermissionSettingsState {
  const OpeningPermissionSettingsState();

  @override
  List<Object?> get props => [];
}

final class OpenedPermissionSettingsState extends OpenPermissionSettingsState {
  const OpenedPermissionSettingsState();

  @override
  List<Object?> get props => [];
}

final class FailedToOpenPermissionSettingsState
    extends OpenPermissionSettingsState {
  const FailedToOpenPermissionSettingsState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
