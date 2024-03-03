// ignore_for_file: public_member_api_docs

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vid_call/models/failure.dart';
import 'package:vid_call/repositories/rtc_engine_ops_repository.dart'
    show RtcEngineOpsRepository;
import 'package:vid_call/resources/strings/ui.dart'
    show
        noEventHandlerToUnregister,
        userEndedTheCall,
        userLeftTheCallDueToBadInternet,
        userSwitchedRole;

part 'real_time_communication_event_state.dart';

final class RealTimeCommunicationEventCubit
    extends Cubit<RealTimeCommunicationEventState> {
  RealTimeCommunicationEventCubit(
    RtcEngineOpsRepository rtcEngineOpsRepository,
  )   : _rtcEngineOpsRepository = rtcEngineOpsRepository,
        super(
          const RealTimeCommunicationEventInitialState(),
        );

  final RtcEngineOpsRepository _rtcEngineOpsRepository;

  RtcEngineEventHandler? _rtcEventHandler;

  Future<void> listenRealTimeCommunicationEvent() async {
    emit(
      const WaitingToListenRealTimeCommunicationEventState(),
    );

    _rtcEventHandler = RtcEngineEventHandler(
      onError: _onError,
      onJoinChannelSuccess: _onJoinChannelSuccess,
      onUserJoined: _onUserJoined,
      onUserOffline: _onUserLeft,
      onUserEnableLocalVideo: _onUserEnableLocalVideo,
      // onLocalAudioStateChanged:
      // onRemoteAudioStateChanged:
    );

    final registerEventHandlerResult =
        await _rtcEngineOpsRepository.registerEventHandler(
      _rtcEventHandler!,
    );

    registerEventHandlerResult.fold(
      _listenFailure,
      _listenSuccess,
    );
  }

  Future<void> stopListeningRealTimeCommunicationEvent() async {
    if (_rtcEventHandler != null) {
      final unregisterEventHandlerResult =
          await _rtcEngineOpsRepository.unregisterEventHandler(
        _rtcEventHandler!,
      );

      unregisterEventHandlerResult.fold(
        _stopListeningFailure,
        _stopListeningSuccess,
      );
    } else {
      _stopListeningFailure(
        const Failure(
          noEventHandlerToUnregister,
        ),
      );
    }
  }

  void _onError(
    ErrorCodeType codeType,
    String message,
  ) =>
      emit(
        ErrorState(
          Failure(
            message,
          ),
        ),
      );

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

  void _onUserEnableLocalVideo(
    RtcConnection connection,
    int remoteUserId,
    bool enabled,
  ) =>
      emit(
        switch (enabled) {
          true => RemoteUserEnabledLocalVideoState(
              remoteUserId,
            ),
          false => RemoteUserDisabledLocalVideoState(
              remoteUserId,
            ),
        },
      );

  void _listenFailure(
    Failure failure,
  ) =>
      emit(
        FailedToListenRealTimeCommunicationEventState(
          failure,
        ),
      );

  void _listenSuccess(
    void _,
  ) =>
      emit(
        const ListeningRealTimeCommunicationEventState(),
      );

  void _stopListeningFailure(
    Failure failure,
  ) =>
      emit(
        FailedToStopListeningRealTimeCommunicationEventState(
          failure,
        ),
      );

  void _stopListeningSuccess(
    void _,
  ) {
    emit(
      const StoppedListeningRealTimeCommunicationEventState(),
    );

    _rtcEventHandler = null;
  }
}
