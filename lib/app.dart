import 'package:flutter/material.dart';
import 'resources/colors.dart' show baseColor;
import 'resources/strings/routes.dart' show videoCallScreenRoute;
import 'views/screens/home_screen.dart';
import 'views/screens/video_call_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: const HomeScreen(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: baseColor,
          ),
        ),
        onGenerateRoute: _routes,
      );

  Route _routes(RouteSettings settings) => MaterialPageRoute(
        builder: (_) => switch (settings.name) {
          videoCallScreenRoute => const VideoCallScreen(),
          _ => const HomeScreen(),
        },
      );
}
