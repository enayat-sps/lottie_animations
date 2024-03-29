import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../config/constants/assets_path.dart';
import '../data/provider/river_providers.dart';
import '../screens/auth_screen.dart';

class Splash extends ConsumerStatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  ConsumerState<Splash> createState() => _SplashState();
}

class _SplashState extends ConsumerState<Splash> {
  @override
  void initState() {
    super.initState();
    ref.read(userListProvider);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: Lottie.asset(AssetPathLottie.colorLoaderAnimation),
      splashIconSize: 200,
      screenFunction: () async {
        return const AuthScreen();
      },
    );
  }
}
