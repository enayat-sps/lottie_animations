import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/constants/constants.dart';
import '../screens/error_screen.dart';
import '../screens/home.dart';
import '../screens/splash.dart';

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
      routes: {
        '/': (context) => const Splash(),
        'home': (context) => const Home(),
        'error': (context) => const ErrorScreen(),
      },
    );
  }
}
