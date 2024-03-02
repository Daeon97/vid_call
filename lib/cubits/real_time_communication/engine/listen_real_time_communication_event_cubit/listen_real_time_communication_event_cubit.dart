// ignore_for_file: public_member_api_docs

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/repositories/rtc_engine_ops_repository.dart'
    show RtcEngineOpsRepository;
import 'package:vid_call/resources/strings/ui.dart'
    show userEndedTheCall, userLeftTheCallDueToBadInternet, userSwitchedRole;

part 'listen_real_time_communication_event_state.dart';

final class ListenRealTimeCommunicationEventCubit
    extends Cubit<ListenRealTimeCommunicationEventState> {
  ListenRealTimeCommunicationEventCubit(
    RtcEngineOpsRepository rtcEngineOpsRepository,
  )   : _rtcEngineOpsRepository = rtcEngineOpsRepository,
        super(
          const ListenRealTimeCommunicationEventInitialState(),
        );

  final RtcEngineOpsRepository _rtcEngineOpsRepository;

  Future<void> listenRealTimeCommunicationEvent() async {
    emit(
      const WaitingToListenRealTimeCommunicationEventState(),
    );

    final registerEventHandlerResult =
        await _rtcEngineOpsRepository.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: _onJoinChannelSuccess,
        onUserJoined: _onUserJoined,
        onUserOffline: _onUserLeft,
        // onUserMuteVideo:
      ),
    );

    registerEventHandlerResult.fold(
      _failure,
      _success,
    );
  }

  void _onJoinChannelSuccess(
    RtcConnection connection,
    int elapsed,
  ) =>
      emit(
        const ChannelJoinedState(),
      );

  void _onUserJoined(
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

  void _onUserLeft(
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

  void _failure(
    Failure failure,
  ) =>
      emit(
        FailedToListenRealTimeCommunicationEventState(
          failure,
        ),
      );

  void _success(
    void _,
  ) =>
      emit(
        const ListeningRealTimeCommunicationEventState(),
      );
}
