import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../config/constants/assets_path.dart';

class ShowError extends StatelessWidget {
  const ShowError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(AssetPathLottie.errorAnimation),
    );
  }
}
