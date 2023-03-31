import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import '../models/users_model.dart';
import '../services//api_client.dart';
import '../services//dio_client.dart';

final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(
    dioClient(),
  ),
);

final userListProvider = FutureProvider<UsersModel>((ref) {
  try {
    return ref.read(apiClientProvider).getUsers(1, 5);
  } on Exception catch (e) {
    debugPrint(
      e.toString(),
    );
    rethrow;
  }
});

final userDataProvider = FutureProvider.autoDispose((ref) async {
  final client = ApiClient(dioClient());
  try {
    final response = await client.getUsers(1, 12);
    return response;
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
  return null;
});

final singleUserProvider =
    FutureProvider.autoDispose.family<User, int>((ref, id) async {
  try {
    final client = ApiClient(dioClient());
    final response = await client.getSingleUser(id);
    return response;
  } on Error catch (error) {
    print(error);
    rethrow;
  }
});
