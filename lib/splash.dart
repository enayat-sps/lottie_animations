import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../data/provider/users_provider.dart';
import '../config/constants/assets_path.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    final userProvider = ChangeNotifierProvider(
      (ref) {
        UsersProvider();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(AssetPath.colorLoaderAnimation),
    );
  }
}
