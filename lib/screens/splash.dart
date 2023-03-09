import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../config/constants/assets_path.dart';
import '../screens/home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: Lottie.asset(AssetPath.colorLoaderAnimation),
      splashIconSize: 200,
      screenFunction: () async {
        return const Home();
      },
    );
  }
}
