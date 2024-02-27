// ignore_for_file: public_member_api_docs

part of 'create_video_view_cubit.dart';

abstract final class CreateVideoViewState extends Equatable {
  const CreateVideoViewState();
}

final class CreateVideoViewInitialState extends CreateVideoViewState {
  const CreateVideoViewInitialState();

  @override
  List<Object?> get props => [];
}

final class CreatedVideoViewState extends CreateVideoViewState {
  const CreatedVideoViewState(
    this.agoraVideoView,
  );

  final AgoraVideoView agoraVideoView;

  @override
  List<Object?> get props => [
        agoraVideoView,
      ];
}
