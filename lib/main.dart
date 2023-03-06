import 'package:flutter/material.dart';
import 'package:lottie_animations/screens/home.dart';
import 'package:provider/provider.dart';

import 'package:lottie_animations/config/constants/constants.dart';
import 'package:lottie_animations/data/provider/users_provider.dart';
import '../splash.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UsersProvider(),
      child: MaterialApp(
        title: appTitle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/':(context) => const Splash(),
          'home':(context) => const Home(),
        },
      ),
    );
  }
}
