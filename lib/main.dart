import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/constants/constants.dart';
import '../config/routes/routes.dart';
import '../screens/error_screen.dart';
import '../screens/home.dart';
import '../screens/image_editing_screen.dart';
import '../screens/splash.dart';
import '../screens/user_detail_screen.dart';

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
        RoutePaths.homeScreen: (context) => const Home(),
        RoutePaths.errorScreen: (context) => const ErrorScreen(),
        RoutePaths.userDetailScreen: (context) => const UserDetailScreen(),
        RoutePaths.imageEditingScreen: (context) => const ImageEditingScreen(),
      },
    );
  }
}
