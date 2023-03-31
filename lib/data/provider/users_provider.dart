import 'package:flutter/material.dart';

import '/data/models/user.dart';
import '/data/models/users_model.dart';
import '../services/api_client.dart';
import '../services/dio_client.dart';

class UsersProvider extends ChangeNotifier {
  UsersModel? users;
  User? user;
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
      user = value;
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error);
      isLoading = false;
      notifyListeners();
    });
  }
}
