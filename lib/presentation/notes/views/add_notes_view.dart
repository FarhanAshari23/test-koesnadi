// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_koesnadi/common/bloc/button/button_cubit.dart';
import 'package:test_koesnadi/common/bloc/button/button_state.dart';
import 'package:test_koesnadi/data/model/notes/notes.dart';
import 'package:test_koesnadi/domain/usecase/notes/create_notes.dart';

import '../../../common/helper/app_navigation.dart';
import '../../../common/widgets/button/basic_reactive_button.dart';
import '../../home/views/home_view.dart';

class AddNotesView extends StatelessWidget {
  TextEditingController titleC = TextEditingController();
  TextEditingController contentC = TextEditingController();
  AddNotesView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    List<String> hintText = ['Title:', 'Content:'];
    List<int> maxLines = [2, 8];
    List<TextEditingController> controller = [titleC, contentC];
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lets Create a New Note!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: height * 0.025),
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.425,
                    child: ListView.separated(
                      itemBuilder: (context, index) => TextField(
                        autocorrect: false,
                        controller: controller[index],
                        maxLines: maxLines[index],
                        decoration: InputDecoration(hintText: hintText[index]),
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: height * 0.01),
                      itemCount: hintText.length,
                      scrollDirection: Axis.vertical,
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      return BasicReactiveButton(
                        onPressed: () {
                          if (titleC.text.isEmpty || contentC.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title:
                                      const Text('All Fields is still empty'),
                                  content: const Text(
                                      'Please fill title and content to save the notes!'),
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
                            context.read<ButtonStateCubit>().execute(
                                  usecase: CreateNotesUseCase(),
                                  params: NotesModel(
                                    title: titleC.text,
                                    content: contentC.text,
                                    createdAt: Timestamp.now(),
                                  ),
                                );
                          }
                        },
                        title: "Add Note",
                      );
                    },
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
