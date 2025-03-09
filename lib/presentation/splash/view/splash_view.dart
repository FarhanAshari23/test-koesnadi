import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_koesnadi/core/configs/assets/app_images.dart';
import 'package:test_koesnadi/presentation/home/views/home_view.dart';

import '../../../common/helper/app_navigation.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../auth/views/login_view.dart';
import '../bloc/splash_cubit.dart';
import '../bloc/splash_state.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) async {
        if (state is UnAuthenticated) {
          AppNavigator.push(context, LoginView());
        }
        if (state is Authenticated) {
          AppNavigator.push(context, HomeView());
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: SizedBox(
            width: 400,
            height: 400,
            child: Image.asset(AppImages.splashLogin),
          ),
        ),
      ),
    );
  }
}
