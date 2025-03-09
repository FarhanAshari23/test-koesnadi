// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:test_koesnadi/core/configs/theme/app_colors.dart';
import 'package:test_koesnadi/data/model/auth/signin_user_req.dart';

import '../../../common/helper/app_navigation.dart';
import '../../../common/widgets/appbar/basic_appbar.dart';
import '../../../common/widgets/button/basic_app_button.dart';
import 'enter_password.dart';
import 'signup.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  TextEditingController emailC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const BasicAppbar(
        hideBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _signInText(context),
            const SizedBox(height: 20),
            _emailField(context),
            const SizedBox(height: 20),
            _continueButton(context),
            const SizedBox(height: 10),
            _createAccount(context),
          ],
        ),
      ),
    );
  }

  Widget _signInText(BuildContext context) {
    return const Text(
      'Sign In',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      autocorrect: false,
      controller: emailC,
      decoration: const InputDecoration(
        hintText: "Enter Email:",
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    return BasicAppButton(
      onPressed: () => emailC.text.isEmpty
          ? showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Email Field is Empty'),
                  content: const Text('Please input your email!'),
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
            )
          : AppNavigator.push(
              context,
              EnterPasswordPage(
                userSignInReq: SignInUserReq(email: emailC.text),
              ),
            ),
      title: "Continue",
    );
  }

  Widget _createAccount(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Dont have Account?",
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        TextButton(
          onPressed: () => AppNavigator.push(
            context,
            SignUpPage(),
          ),
          child: const Text(
            "Create One",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
