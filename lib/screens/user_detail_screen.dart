import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie_animations/config/routes/routes.dart';

import '../data/models/user.dart';
import '../data/provider/user_provider.dart';
import '../utils/show_error.dart';
import '../utils/show_loader.dart';

class UserDetailScreen extends ConsumerWidget {
  const UserDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ModalRoute.of(context)?.settings.arguments as int;
    final user = ref.watch(userProvider(userId));
    return Scaffold(
      appBar: AppBar(),
      body: user.when(
        data: (data) {
          final user = data;
          return detailsWidget(user, context);
        },
        error: (error, stackTrace) => const ShowError(),
        loading: () => const ShowLoader(),
      ),
    );
  }
}

Widget detailsWidget(User user, BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(
          color: Colors.amberAccent,
          width: double.infinity,
          height: 300,
          child: InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              RoutePaths.imageEditingScreen,
            ),
            child: Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 80,
                vertical: 50,
              ),
              elevation: 10,
              child: Image.network(
                user.data!.avatar!,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Container(
          color: Colors.deepOrangeAccent,
          height: 500,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Text(
                  user.data!.id!.toString(),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Text(
                user.data!.firstName!,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                user.data!.lastName!,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
        )
      ],
    ),
  );
}
