import 'package:agora_rtc_engine/agora_rtc_engine.dart';

abstract interface class AudioOpsRepository
    with _LocalAudioOpsRepository, _RemoteAudioOpsRepository {
  Future<void> enableAudio();

  Future<void> disableAudio();
}

abstract mixin class _LocalAudioOpsRepository {
  Future<void> enableLocalAudio();

  Future<void> disableLocalAudio();

  Future<void> muteLocalAudioStream();

  Future<void> unMuteLocalAudioStream();
}

abstract mixin class _RemoteAudioOpsRepository {
  Future<void> muteRemoteAudioStream(
    int userId,
  );

  Future<void> unMuteRemoteAudioStream(
    int userId,
  );

  Future<void> muteAllRemoteAudioStreams();

  Future<void> unMuteAllRemoteAudioStreams();
}

/* TODO(Daeon97): Modify this implementation to pass calls to a
    util class that can catch and handle errors thrown from Agora */
final class AudioOpsRepositoryImplementation implements AudioOpsRepository {
  const AudioOpsRepositoryImplementation(
    RtcEngine rtcService,
  ) : _rtcService = rtcService;

  final RtcEngine _rtcService;

  @override
  Future<void> enableLocalAudio() => _rtcService.enableLocalAudio(
        true,
      );

  @override
  Future<void> disableLocalAudio() => _rtcService.enableLocalAudio(
        false,
      );

  @override
  Future<void> muteLocalAudioStream() => _rtcService.muteLocalAudioStream(
        true,
      );

  @override
  Future<void> unMuteLocalAudioStream() => _rtcService.muteLocalAudioStream(
        false,
      );

  @override
  Future<void> enableAudio() => _rtcService.enableAudio();

  @override
  Future<void> disableAudio() => _rtcService.disableAudio();

  @override
  Future<void> muteRemoteAudioStream(
    int userId,
  ) =>
      _rtcService.muteRemoteAudioStream(
        uid: userId,
        mute: true,
      );

  @override
  Future<void> unMuteRemoteAudioStream(
    int userId,
  ) =>
      _rtcService.muteRemoteAudioStream(
        uid: userId,
        mute: false,
      );

  @override
  Future<void> muteAllRemoteAudioStreams() =>
      _rtcService.muteAllRemoteAudioStreams(
        true,
      );

  @override
  Future<void> unMuteAllRemoteAudioStreams() =>
      _rtcService.muteAllRemoteAudioStreams(
        false,
      );
}
