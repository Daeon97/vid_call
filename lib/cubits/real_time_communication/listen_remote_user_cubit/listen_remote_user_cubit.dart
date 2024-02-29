// ignore_for_file: public_member_api_docs

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/repositories/video_ops_repository.dart'
    show VideoOpsRepository;
import 'package:vid_call/resources/strings/ui.dart'
    show userEndedTheCall, userLeftTheCallDueToBadInternet, userSwitchedRole;

part 'listen_remote_user_state.dart';

final class ListenRemoteUserCubit extends Cubit<ListenRemoteUserState> {
  ListenRemoteUserCubit(
    VideoOpsRepository videoOpsRepository,
  )   : _videoOpsRepository = videoOpsRepository,
        super(
          const ListenRemoteUserInitialState(),
        );

  final VideoOpsRepository _videoOpsRepository;

  Future<void> listenRemoteUser() async {
    void onUserJoined(
      RtcConnection connection,
      int remoteUserId,
      int elapsed,
    ) =>
        emit(
          RemoteUserJoinedState(
            remoteUserId: remoteUserId,
            elapsed: elapsed,
          ),
        );

    void onUserLeft(
      RtcConnection connection,
      int remoteUserId,
      UserOfflineReasonType reason,
    ) =>
        emit(
          RemoteUserLeftState(
            remoteUserId: remoteUserId,
            failure: Failure(
              switch (reason) {
                UserOfflineReasonType.userOfflineQuit => userEndedTheCall,
                UserOfflineReasonType.userOfflineDropped =>
                  userLeftTheCallDueToBadInternet,
                UserOfflineReasonType.userOfflineBecomeAudience =>
                  userSwitchedRole,
              },
            ),
          ),
        );

    final registerEventHandlerResult =
        await _videoOpsRepository.registerEventHandler(
      RtcEngineEventHandler(
        onUserJoined: onUserJoined,
        onUserOffline: onUserLeft,
      ),
    );

    registerEventHandlerResult.fold(
      _failure,
      _success,
    );

    emit(
      const WaitingForRemoteUserState(),
    );
  }

  void _failure(
    Failure failure,
  ) =>
      emit(
        ListenRemoteUserFailedState(
          failure,
        ),
      );

  void _success(
    void _,
  ) =>
      emit(
        const ListenRemoteUserSuccessState(),
      );
}
