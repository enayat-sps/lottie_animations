import 'package:flutter/material.dart';
import 'package:lottie_animations/utils/loader.dart';
import 'package:provider/provider.dart';

import '../data/provider/users_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UsersProvider>();
    final userData = userProvider.users?.data;
    return Scaffold(
      appBar: AppBar(),
      body: userData == null || userData.isEmpty
          ? const Loader()
          : ListView.builder(
              itemCount: userData.length,
              itemBuilder: (context, index) {
                SizedBox(
                  height: 250,
                  child: Card(
                    child: Column(
                      children: [
                        Image.network(userData[index].avatar!,height: 80,),
                        Text(userData[index].firstName!),
                        Text(userData[index].lastName!),
                        Text(userData[index].email!),

                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
