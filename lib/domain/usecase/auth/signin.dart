import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../data/model/auth/signin_user_req.dart';
import '../../../service_locator.dart';
import '../../repository/auth/auth.dart';

class SignInUsecase implements Usecase<Either, SignInUserReq> {
  @override
  Future<Either> call({SignInUserReq? params}) async {
    return await sl<AuthRepository>().signin(params!);
  }
}
