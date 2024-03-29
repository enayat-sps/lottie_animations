import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services//api_client.dart';
import '../services//dio_client.dart';
import '../state/user_state.dart';

class UserNotifier extends StateNotifier<UserState> {
  final _client = ApiClient(dioClient());
  UserNotifier(super.state);

  getUserData(int page, int perPage) async {
    try {
      state = const UserState.loading();
      final userData = await _client.getUsers(page, perPage);
      state = UserState.loaded(userData);
    } catch (error) {
      debugPrint(error.toString());
      state = UserState.error(
        message: 'Unable to fetch users data reason: $error',
      );
    }
  }
}
