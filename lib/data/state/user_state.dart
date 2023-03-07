import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lottie_animations/data/models/users_model.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState() = Initial;
  const factory UserState.loading() = Loading;
  const factory UserState.loaded(UsersModel? user) = UserData;
  const factory UserState.error({String? message}) = Error;
}
