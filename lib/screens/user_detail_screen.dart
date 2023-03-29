import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie_animations/data/models/users_model.dart';

class UserDetailScreen extends ConsumerWidget {
  const UserDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}

Widget detailsWidget(UserData userData) {
  return Column(
    children: [
      Card(
        margin: const EdgeInsets.all(20),
        elevation: 5,
        child: Image.network(userData.avatar!),
      ),
    ],
  );
}
