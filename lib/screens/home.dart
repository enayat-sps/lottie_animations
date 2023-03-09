import 'package:auto_animated/auto_animated.dart';
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
    const options = LiveOptions(
      // Start animation after (default zero)
      delay: Duration(milliseconds: 500),

      // Show each item through (default 250)
      showItemInterval: Duration(milliseconds: 200),

      // Animation duration (default 250)
      showItemDuration: Duration(milliseconds: 500),

      // Animations starts at 0.05 visible
      // item fraction in sight (default 0.025)
      visibleFraction: 0.05,

      // Repeat the animation of the appearance
      // when scrolling in the opposite direction (default false)
      // To get the effect as in a showcase for ListView, set true
      reAnimateOnVisibility: false,
    );

    return Scaffold(
      appBar: AppBar(),
      body: userData.when(
        data: (data) {
          final user = data?.data;
          return LiveList.options(
            itemCount: user?.length ?? 0,
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              return FadeTransition(
                opacity: Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(animation),
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, -0.1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: Padding(
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
                  ),
                ),
              );
            },
            options: options,
          );
        },
        error: (error, stackTrace) => const ShowError(),
        loading: () => const Loader(),
      ),
    );
  }
}
