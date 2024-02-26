// ignore_for_file: public_member_api_docs, explicit_type_arguments

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vid_call/app_bloc_provider.dart';
import 'package:vid_call/resources/colors.dart' show baseColor;
import 'package:vid_call/resources/strings/routes.dart'
    show videoCallScreenRoute;
import 'package:vid_call/views/screens/home_screen.dart';
import 'package:vid_call/views/screens/video_call_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) =>
      MultiBlocProvider(
        providers: appBlocProviders,
        child: MaterialApp(
          home: const HomeScreen(),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: baseColor,
            ),
          ),
          onGenerateRoute: _routes,
        ),
      );

  Route _routes(RouteSettings settings) =>
      MaterialPageRoute(
        builder: (_) =>
        switch (settings.name) {
          videoCallScreenRoute => const VideoCallScreen(),
          _ => const HomeScreen(),
        },
      );
}
