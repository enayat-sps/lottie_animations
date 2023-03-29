import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../config/constants/assets_path.dart';

class ShowLoader extends StatelessWidget {
  const ShowLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        child: Lottie.asset(AssetPathLottie.loadingAnimation),
      ),
    );
  }
}
