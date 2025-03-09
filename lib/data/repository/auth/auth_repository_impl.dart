import 'package:dartz/dartz.dart';
import 'package:test_koesnadi/data/model/auth/user_creation_req.dart';

import '../../../domain/repository/auth/auth.dart';
import '../../../service_locator.dart';
import '../../model/auth/user.dart';
import '../../sources/auth/auth_firebase_service.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthFirebaseService>().isLoggedIn();
  }

  @override
  Future<Either> logout() async {
    return await sl<AuthFirebaseService>().logout();
  }

  @override
  Future<Either> signUp(userCreationReq) async {
    return await sl<AuthFirebaseService>().signUp(userCreationReq);
  }

  @override
  Future<Either> signin(signinUserReq) async {
    return await sl<AuthFirebaseService>().signin(signinUserReq);
  }

  @override
  Future<Either> getUser() async {
    var user = await sl<AuthFirebaseService>().getUser();
    return user.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(UserModel.fromMap(data).toEntity());
      },
    );
  }

  @override
  Future<Either> editUser(UserCreationReq updateUserReq) async {
    return await sl<AuthFirebaseService>().editUser(updateUserReq);
  }
}
