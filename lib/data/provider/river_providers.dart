import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/users_model.dart';
import '../network/api_client.dart';
import '../network/dio_client.dart';

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

AutoDisposeFutureProvider<UsersModel?> userProvider(int page, int perPage) {
  final List<UserData> usersList = [];
  return FutureProvider.autoDispose((ref) async {
    final client = ApiClient(dioClient());
    try {
      final response = await client.getUsers(page, perPage);
      response.data?.forEach((element) {
        usersList.add(element);
      });
      return response;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  });
}

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
