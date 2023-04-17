// HYPHEN DESKTOP

import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:hyphen/splashscreen.dart';
import 'package:window_manager/window_manager.dart';

const apikey = "AIzaSyAmCmGywtriZBnMdHY9I3o6VC9gHo2x58A";
const projectId = "hyphen-roundrobin";

void main() async {
  Firestore.initialize(projectId);
  runApp(const MyApp());
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow(const WindowOptions(
    backgroundColor: Color(0xFF313131),
    size: Size(700.0, 500.0),
    center: true,
    skipTaskbar: false,
    fullScreen: false,
    titleBarStyle: TitleBarStyle.hidden,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "HYPHEN DESKTOP",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
