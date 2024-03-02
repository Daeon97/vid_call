// ignore_for_file: public_member_api_docs

part of 'create_remote_video_view_cubit.dart';

abstract final class CreateRemoteVideoViewState extends Equatable {
  const CreateRemoteVideoViewState();
}

final class CreateRemoteVideoViewInitialState
    extends CreateRemoteVideoViewState {
  const CreateRemoteVideoViewInitialState();

  @override
  List<Object?> get props => [];
}

final class CreatedRemoteVideoViewState extends CreateRemoteVideoViewState {
  const CreatedRemoteVideoViewState(
    this.agoraVideoView,
  );

  final AgoraVideoView agoraVideoView;

  @override
  List<Object?> get props => [
        agoraVideoView,
      ];
}
