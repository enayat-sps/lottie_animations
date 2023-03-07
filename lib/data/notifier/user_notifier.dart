import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/api_client.dart';
import '../network/dio_client.dart';
import '../state/user_state.dart';

class UserNotifier extends StateNotifier<UserState> {
  final _client = ApiClient(dioClient());
  UserNotifier(super.state);
  getUserData() async {
    try {
      state = const UserState.loading();
      final userData = await _client.getUsers();
      state = UserState.loaded(userData);
    } catch (error) {
      debugPrint(error.toString());
      state = UserState.error(
        message: 'Unable to fetch users data reason: $error',
      );
    }
  }
}
