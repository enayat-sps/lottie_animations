import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie_animations/data/models/users_model.dart';
import 'package:lottie_animations/data/network/api_client.dart';
import 'package:lottie_animations/data/network/dio_client.dart';

final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(
    dioClient(),
  ),
);

final userListProvider = FutureProvider<UsersModel>((ref) {
  try {
    return ref.read(apiClientProvider).getUsers();
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
    final response = await client.getUsers();
    return response;
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
});
