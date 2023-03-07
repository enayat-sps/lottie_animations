import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../config/constants/assets_path.dart';
import '../data/provider/users_provider.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // final userProvider = ChangeNotifierProvider(
    //   (ref) {
    //     UsersProvider();
    //   },
    // );
    loadNewPage();
  }

  loadNewPage() async {
    final userProvider = context.read<UsersProvider>();
    await userProvider.getUsers();
    if (!mounted) return;
    if (userProvider.isLoading == false) {
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(AssetPath.colorLoaderAnimation),
    );
  }
}
