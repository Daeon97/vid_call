// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/repositories/permission_handler_repository.dart'
    show PermissionHandlerSettingsRepository;
import 'package:vid_call/resources/strings/ui.dart'
    show weCouldNotOpenAppSettings;

part 'open_permission_settings_state.dart';

final class OpenPermissionSettingsCubit
    extends Cubit<OpenPermissionSettingsState> {
  OpenPermissionSettingsCubit(
    PermissionHandlerSettingsRepository permissionHandlerSettingsRepository,
  )   : _permissionHandlerSettingsRepository =
            permissionHandlerSettingsRepository,
        super(
          const OpenPermissionSettingsInitialState(),
        );

  final PermissionHandlerSettingsRepository
      _permissionHandlerSettingsRepository;

  Future<void> openAppSettings() async {
    emit(
      const OpeningPermissionSettingsState(),
    );

    final openSettingsResult =
        await _permissionHandlerSettingsRepository.openSettings();

    emit(
      switch (openSettingsResult) {
        true => const OpenedPermissionSettingsState(),
        false => const FailedToOpenPermissionSettingsState(
            Failure(
              weCouldNotOpenAppSettings,
            ),
          ),
      },
    );
  }
}
