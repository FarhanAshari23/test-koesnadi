import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_koesnadi/common/bloc/button/button_cubit.dart';
import 'package:test_koesnadi/common/bloc/button/button_state.dart';
import 'package:test_koesnadi/common/widgets/button/basic_app_button.dart';
import 'package:test_koesnadi/core/configs/theme/app_colors.dart';
import 'package:test_koesnadi/data/model/auth/user_creation_req.dart';
import 'package:test_koesnadi/domain/entities/auth/user.dart';
import 'package:test_koesnadi/domain/usecase/auth/edit_user.dart';
import 'package:test_koesnadi/presentation/auth/bloc/gender_selection_cubit.dart';
import 'package:test_koesnadi/presentation/profile/views/profile_view.dart';
import 'package:test_koesnadi/presentation/profile/widgets/card_gender.dart';

import '../../../common/helper/app_navigation.dart';

class EditProfileView extends StatelessWidget {
  final UserEntity user;
  const EditProfileView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController nameC = TextEditingController(text: user.fullName);
    TextEditingController birthDateC =
        TextEditingController(text: user.birthDate);
    TextEditingController zodiacC = TextEditingController(text: user.favorite);
    List<TextEditingController> controller = [
      nameC,
      birthDateC,
      zodiacC,
    ];
    List<String> hintText = ['Name', 'Birth of Date', 'Zodiac'];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GenderSelectionCubit(),
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
              AppNavigator.pushAndRemoveUntil(context, const ProfileView());
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit your profile:',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: height * 0.035),
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.235,
                    child: ListView.separated(
                      itemBuilder: (context, index) => TextField(
                        controller: controller[index],
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: hintText[index],
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: height * 0.01),
                      itemCount: controller.length,
                      scrollDirection: Axis.vertical,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.55,
                    height: height * 0.085,
                    child: BlocBuilder<GenderSelectionCubit, int>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CardGender(
                              gender: 'Man',
                              genderIndex: 1,
                              initGender: user.gender,
                            ),
                            CardGender(
                              gender: 'Woman',
                              genderIndex: 2,
                              initGender: user.gender,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) {
                          return BasicAppButton(
                            width: width * 0.4,
                            onPressed: () {
                              context.read<ButtonStateCubit>().execute(
                                    usecase: EditUserUseCase(),
                                    params: UserCreationReq(
                                      name: nameC.text,
                                      birthDate: birthDateC.text,
                                      favorite: zodiacC.text,
                                      gender: context
                                          .read<GenderSelectionCubit>()
                                          .selectedIndex,
                                    ),
                                  );
                            },
                            title: 'Edit',
                          );
                        },
                      ),
                      BasicAppButton(
                        width: width * 0.4,
                        onPressed: () => Navigator.pop(context),
                        title: 'Back',
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
