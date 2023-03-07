import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie_animations/data/network/api_client.dart';
import 'package:lottie_animations/data/network/dio_client.dart';
import 'package:lottie_animations/data/state/user_state.dart';

import '../notifier/user_notifier.dart';

final userClientProvider = Provider<UserState>((ref) => const UserState());

final userNotifierProvider = StateNotifierProvider(
  (ref) => UserNotifier(
    ref.watch(userClientProvider),
  ),
);

final userDataProvider = FutureProvider.autoDispose((ref) async {
  final client = ApiClient(dioClient());
  try {
    final response = await client.getUsers();
    return response;
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
});
