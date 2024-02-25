import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../repositories/video_ops_repository.dart' show VideoOpsRepository;
import '../resources/strings/environment.dart' show appId;

abstract final class InitCallViewModel {
  Future<void> init();
}

final class InitCallViewModelImplementation extends ChangeNotifier
    implements InitCallViewModel {
  InitCallViewModelImplementation(
    VideoOpsRepository videoOpsRepository,
  ) : _videoOpsRepository = videoOpsRepository;

  final VideoOpsRepository _videoOpsRepository;

  @override
  Future<void> init() async {
    final initializationResult = await _videoOpsRepository.initialize(
      dotenv.env[appId]!,
    );
    // await _videoOpsRepository
  }
}
