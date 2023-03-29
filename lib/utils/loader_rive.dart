import 'package:flutter/material.dart';
import 'package:lottie_animations/config/constants/assets_path.dart';
import 'package:rive/rive.dart';

class LoaderRive extends StatelessWidget {
  const LoaderRive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: RiveAnimation.asset(AssetPathRive.loadingAnimation),
    );
  }
}
