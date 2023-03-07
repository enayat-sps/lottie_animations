import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../config/constants/assets_path.dart';
import '../config/constants/constants.dart';
import '../screens/error_screen.dart';
import '../screens/home.dart';
import '../splash.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen.withScreenFunction(
        splash: Lottie.asset(AssetPath.colorLoaderAnimation),
        splashIconSize: 200,
        screenFunction: () async {
          return const Home();
        },
      ),
      routes: {
        'splash': (context) => const Splash(),
        'home': (context) => const Home(),
        'error': (context) => const ErrorScreen(),
      },
    );
  }
}
