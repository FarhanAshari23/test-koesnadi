import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_koesnadi/common/bloc/button/button_cubit.dart';
import 'package:test_koesnadi/common/bloc/button/button_state.dart';
import 'package:test_koesnadi/common/widgets/button/basic_app_button.dart';
import 'package:test_koesnadi/core/configs/theme/app_colors.dart';
import 'package:test_koesnadi/domain/entities/notes/notes.dart';
import 'package:test_koesnadi/domain/usecase/notes/update_notes.dart';

import '../../../common/helper/app_navigation.dart';
import '../../home/views/home_view.dart';

class EditNotesView extends StatelessWidget {
  final NotesEntity notes;
  const EditNotesView({
    super.key,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> textTitle = ValueNotifier(notes.title);
    final ValueNotifier<String> textContent = ValueNotifier(notes.content);
    TextEditingController titleC = TextEditingController();
    TextEditingController contentC = TextEditingController();
    titleC.text = textTitle.value;
    contentC.text = textContent.value;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
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
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What do you want to edit?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  TextField(
                    autocorrect: false,
                    controller: titleC,
                    maxLines: 2,
                    onChanged: (text) {
                      textTitle.value = text;
                    },
                    decoration: InputDecoration(
                      hintText: 'Title:',
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  TextField(
                    autocorrect: false,
                    controller: contentC,
                    maxLines: 6,
                    onChanged: (text) {
                      textContent.value = text;
                    },
                    decoration: InputDecoration(
                      hintText: 'Content:',
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  Builder(builder: (context) {
                    return BasicAppButton(
                      onPressed: () {
                        context.read<ButtonStateCubit>().execute(
                              usecase: UpdateNotesUseCase(),
                              params: NotesEntity(
                                title: titleC.text,
                                content: contentC.text,
                                createdAt: Timestamp.now(),
                              ),
                            );
                      },
                      title: "Edit",
                    );
                  }),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Go Back',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: AppColors.tertiary,
                        ),
                      ),
                    ),
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
