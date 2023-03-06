import 'package:flutter/material.dart';
import 'package:lottie_animations/data/network/dio_client.dart';
import '/data/models/users_model.dart';
import '/data/network/api_client.dart';

class UsersProvider extends ChangeNotifier {
  UsersModel? users;
  final client = ApiClient(dioClient());
  bool isLoading = false;

  getUsers() async {
    isLoading = true;
    await client.getUsers().then((value) {
      users = value;
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error);
    });
  }
}
