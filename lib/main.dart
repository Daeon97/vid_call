// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vid_call/app.dart';
import 'package:vid_call/app_bloc_observer.dart';
import 'package:vid_call/injection_container.dart' show registerServices;

void main() => _init().then(
      (_) => runApp(
        const App(),
      ),
    );

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  registerServices();

  Bloc.observer = const AppBlocObserver();
}
