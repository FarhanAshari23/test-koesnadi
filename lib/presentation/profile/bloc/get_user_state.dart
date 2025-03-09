import 'package:test_koesnadi/domain/entities/auth/user.dart';

abstract class GetUserState {}

class GetUserLoading extends GetUserState {}

class GetUserLoaded extends GetUserState {
  final UserEntity user;

  GetUserLoaded({required this.user});
}

class GetUserFail extends GetUserState {
  final String errorMessage;

  GetUserFail({required this.errorMessage});
}
