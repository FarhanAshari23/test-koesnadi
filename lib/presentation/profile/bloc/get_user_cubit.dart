import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_koesnadi/domain/usecase/auth/get_user.dart';
import 'package:test_koesnadi/presentation/profile/bloc/get_user_state.dart';

import '../../../service_locator.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit() : super(GetUserLoading());

  Future<void> getUser() async {
    var user = await sl<GetUserUsecase>().call();
    user.fold(
      (error) {
        emit(GetUserFail(errorMessage: error));
      },
      (user) {
        emit(GetUserLoaded(user: user));
      },
    );
  }
}
