import 'package:dartz/dartz.dart';
import 'package:test_koesnadi/data/model/auth/user_creation_req.dart';
import 'package:test_koesnadi/domain/repository/auth/auth.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';

class EditUserUseCase implements Usecase<Either, UserCreationReq> {
  @override
  Future<Either> call({UserCreationReq? params}) async {
    return await sl<AuthRepository>().editUser(params!);
  }
}
