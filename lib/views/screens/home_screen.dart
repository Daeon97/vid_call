import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import '../../resources/colors.dart' show cameraPreviewSurfaceColor;
import '../../resources/numbers/dimensions.dart' show spacing;
import '../../resources/numbers/constants.dart'
    show oneDotFive, sixteenDotNil, twoDotNil;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _channelIdController;

  @override
  void initState() {
    _channelIdController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _channelIdController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.all(
              spacing,
            ),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / twoDotNil,
                  width: MediaQuery.of(context).size.width / oneDotFive,
                  decoration: BoxDecoration(
                    color: cameraPreviewSurfaceColor,
                    borderRadius: BorderRadiusDirectional.circular(
                      sixteenDotNil,
                    ),
                  ),
                ),
                const SizedBox(
                  height: spacing,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                        shape: MaterialStatePropertyAll<OutlinedBorder>(
                          CircleBorder(),
                        ),
                        padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                          EdgeInsetsDirectional.all(
                            spacing,
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.camera,
                      ),
                    ),
                    const SizedBox(
                      width: spacing,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                        shape: MaterialStatePropertyAll<OutlinedBorder>(
                          CircleBorder(),
                        ),
                        padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                          EdgeInsetsDirectional.all(
                            spacing,
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.mic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        //   AgoraVideoView(
        //     controller: VideoViewController(
        //         rtcEngine: // Pass in the engine instance created on initState,
        //         canvas: VideoCanvas(),
        //     useFlutterTexture: true,
        //     useAndroidSurfaceView: true,
        //   ),
        // ),
      );
}
