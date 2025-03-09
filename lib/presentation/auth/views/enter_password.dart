// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_koesnadi/data/model/auth/signin_user_req.dart';
import 'package:test_koesnadi/presentation/home/views/home_view.dart';

import '../../../common/bloc/button/button_cubit.dart';
import '../../../common/bloc/button/button_state.dart';
import '../../../common/helper/app_navigation.dart';
import '../../../common/widgets/appbar/basic_appbar.dart';
import '../../../common/widgets/button/basic_reactive_button.dart';
import '../../../domain/usecase/auth/signin.dart';
import '../bloc/password_cubit.dart';

class EnterPasswordPage extends StatelessWidget {
  final SignInUserReq userSignInReq;
  TextEditingController passC = TextEditingController();
  EnterPasswordPage({
    required this.userSignInReq,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const BasicAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 40,
        ),
        child: BlocProvider(
          create: (context) => ButtonStateCubit(),
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
                AppNavigator.pushAndRemoveUntil(context, const HomeView());
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _signInText(context),
                const SizedBox(height: 20),
                _passwordField(context),
                const SizedBox(height: 20),
                _continueButton(context),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInText(BuildContext context) {
    return const Text(
      'Sign In',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget _passwordField(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordCubit(),
      child: BlocBuilder<PasswordCubit, bool>(
        builder: (context, isPasswordHidden) {
          return TextField(
            obscureText: isPasswordHidden,
            controller: passC,
            decoration: InputDecoration(
              hintText: "Enter Password:",
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<PasswordCubit>().togglePasswordVisibility();
                },
                icon: Icon(
                  isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return BasicReactiveButton(
          onPressed: () {
            if (passC.text.isEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Password Field is Empty'),
                    content: const Text('Please input your password!'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              userSignInReq.password = passC.text;
              context.read<ButtonStateCubit>().execute(
                    usecase: SignInUsecase(),
                    params: userSignInReq,
                  );
            }
          },
          title: "Continue",
        );
      },
    );
  }
}
