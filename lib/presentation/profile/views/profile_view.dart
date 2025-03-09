import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_koesnadi/common/bloc/button/button_cubit.dart';
import 'package:test_koesnadi/common/bloc/button/button_state.dart';
import 'package:test_koesnadi/common/widgets/button/basic_app_button.dart';
import 'package:test_koesnadi/core/configs/assets/app_images.dart';
import 'package:test_koesnadi/core/configs/theme/app_colors.dart';
import 'package:test_koesnadi/presentation/auth/views/login_view.dart';
import 'package:test_koesnadi/presentation/profile/bloc/get_user_cubit.dart';
import 'package:test_koesnadi/presentation/profile/bloc/get_user_state.dart';
import 'package:test_koesnadi/presentation/profile/views/edit_profile_view.dart';

import '../../../common/helper/app_navigation.dart';
import '../../../domain/usecase/auth/logout.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GetUserCubit()..getUser(),
          ),
          BlocProvider(
            create: (context) => ButtonStateCubit(),
          ),
        ],
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonFailureState) {
              var snackbar = SnackBar(
                content: Text(state.errorMessage),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
            if (state is ButtonSuccessState) {
              AppNavigator.pushAndRemoveUntil(context, LoginView());
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: height * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(12),
                      color: AppColors.secondary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: BlocBuilder<GetUserCubit, GetUserState>(
                        builder: (context, state) {
                          if (state is GetUserLoading) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (state is GetUserLoaded) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: SizedBox(
                                width: double.infinity,
                                height: height * 0.2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: width * 0.25,
                                      height: height * 0.15,
                                      child: Center(
                                        child: Image.asset(
                                          state.user.gender == 1
                                              ? AppImages.man
                                              : AppImages.woman,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 16,
                                        bottom: 16,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: width * 0.4,
                                            height: height * 0.075,
                                            child: Text(
                                              state.user.fullName,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800,
                                                color: AppColors.inversePrimary,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            state.user.birthDate,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                              color: AppColors.inversePrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () => AppNavigator.push(
                                              context,
                                              EditProfileView(user: state.user),
                                            ),
                                            child: Container(
                                              width: width * 0.1,
                                              height: height * 0.05,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.primary,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.edit,
                                                  color:
                                                      AppColors.inversePrimary,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            state.user.favorite,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: AppColors.inversePrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          if (state is GetUserFail) {
                            return Center(child: Text(state.errorMessage));
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.025),
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.4,
                    child: Image.asset(AppImages.splashLogout),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    'Are you sure want to logout?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: height * 0.025),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Builder(builder: (context) {
                      return BasicAppButton(
                        onPressed: () {
                          context.read<ButtonStateCubit>().execute(
                                usecase: LogoutUsecase(),
                              );
                        },
                        title: 'Logout Account',
                      );
                    }),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Go Back',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
