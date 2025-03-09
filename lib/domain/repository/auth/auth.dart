import 'package:dartz/dartz.dart';

import '../../../data/model/auth/signin_user_req.dart';
import '../../../data/model/auth/user_creation_req.dart';

abstract class AuthRepository {
  Future<Either> signin(SignInUserReq signinUserReq);
  Future<Either> signUp(UserCreationReq userCreationReq);
  Future<Either> editUser(UserCreationReq updateUserReq);
  Future<Either> getUser();
  Future<Either> logout();
  Future<bool> isLoggedIn();
}
