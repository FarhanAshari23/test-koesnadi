// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:test_koesnadi/data/model/auth/user_creation_req.dart';
import 'package:test_koesnadi/presentation/auth/views/login_view.dart';

import '../../../common/helper/app_navigation.dart';
import '../../../common/widgets/appbar/basic_appbar.dart';
import '../../../common/widgets/button/basic_app_button.dart';
import '../../../core/configs/theme/app_colors.dart';
import 'gender_and_age_selection.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController fullnameC = TextEditingController();
  TextEditingController birthDateC = TextEditingController();
  TextEditingController favoriteC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const BasicAppbar(
        hideBack: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _signInText(context),
              const SizedBox(height: 20),
              _textField(context, "Email", emailC),
              const SizedBox(height: 20),
              _textField(context, "Password", passwordC),
              const SizedBox(height: 20),
              _textField(context, "Full Name", fullnameC),
              const SizedBox(height: 20),
              _textField(context, "Birth of Date", birthDateC),
              const SizedBox(height: 20),
              _textField(context, "Zodiac", favoriteC),
              const SizedBox(height: 20),
              _continueButton(context),
              const SizedBox(height: 10),
              _createAccount(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInText(BuildContext context) {
    return const Text(
      'Create Account',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget _textField(
      BuildContext context, String hinttext, TextEditingController controller) {
    return TextField(
      controller: controller,
      autocorrect: false,
      decoration: InputDecoration(
        hintText: hinttext,
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    return BasicAppButton(
      onPressed: () {
        if (fullnameC.text.isEmpty ||
            emailC.text.isEmpty ||
            passwordC.text.isEmpty ||
            favoriteC.text.isEmpty ||
            passwordC.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColors.inversePrimary,
              content: Text(
                'Please fill all the textfield',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else {
          AppNavigator.push(
            context,
            GenderAndAgeSelectionPage(
              userCreationReq: UserCreationReq(
                email: emailC.text,
                password: passwordC.text,
                name: fullnameC.text,
                birthDate: birthDateC.text,
                favorite: favoriteC.text,
              ),
            ),
          );
        }
      },
      title: "Create",
    );
  }

  Widget _createAccount(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Already have an Account?",
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        TextButton(
          onPressed: () => AppNavigator.pushReplacement(
            context,
            LoginView(),
          ),
          child: const Text(
            "Sign In",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
