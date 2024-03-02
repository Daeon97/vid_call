// ignore_for_file: public_member_api_docs

part of 'create_local_video_view_cubit.dart';

abstract final class CreateLocalVideoViewState extends Equatable {
  const CreateLocalVideoViewState();
}

final class CreateLocalVideoViewInitialState extends CreateLocalVideoViewState {
  const CreateLocalVideoViewInitialState();

  @override
  List<Object?> get props => [];
}

final class CreatedLocalVideoViewState extends CreateLocalVideoViewState {
  const CreatedLocalVideoViewState(
    this.agoraVideoView,
  );

  final AgoraVideoView agoraVideoView;

  @override
  List<Object?> get props => [
        agoraVideoView,
      ];
}
