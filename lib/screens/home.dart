import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../config/constants/assets_path.dart';
import '../config/constants/constants.dart';
import '../data/provider/providers.dart';
import '../utils/loader.dart';
import '../utils/show_error.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);

    return Scaffold(
        appBar: AppBar(),
        body: userData.when(
          data: (data) {
            final user = data?.data;
            return ListView.builder(
              itemCount: user?.length ?? 0,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 20,
                  ),
                  child: SizedBox(
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  Navigator.of(context).pushNamed('error'),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  user![index].avatar!,
                                ),
                                onBackgroundImageError:
                                    (exception, stackTrace) {
                                  Lottie.asset(AssetPath.errorAnimation);
                                },
                                radius: 50,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text('$firstNameText${user[index].firstName!}'),
                            Text('$lastNameText ${user[index].lastName!}'),
                            Text('$emailText ${user[index].email!}'),
                            Text('$userIdText${user[index].id!}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) => const ShowError(),
          loading: () => const Loader(),
        ));
  }
}
