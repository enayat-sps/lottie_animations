import 'package:flutter/material.dart';
import 'package:lottie_animations/data/network/dio_client.dart';

import '/data/models/users_model.dart';
import '/data/network/api_client.dart';

class UsersProvider extends ChangeNotifier {
  UsersModel? users;
  final client = ApiClient(dioClient());
  bool isLoading = false;

  getUsers(int page, int perPage) async {
    isLoading = true;
    await client.getUsers(page, perPage).then((value) {
      users = value;
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error);
      isLoading = false;
      notifyListeners();
    });
  }


  getSingleUser(int userID) async {
    isLoading = true;
    await client.getSingleUser(userID).then((value) {
      users = value;
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error);
      isLoading = false;
      notifyListeners();
    });
  }
}
