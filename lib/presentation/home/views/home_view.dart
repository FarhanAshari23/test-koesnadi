import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_koesnadi/common/helper/app_navigation.dart';
import 'package:test_koesnadi/core/configs/theme/app_colors.dart';
import 'package:test_koesnadi/presentation/home/bloc/get_notes_cubit.dart';
import 'package:test_koesnadi/presentation/home/bloc/get_notes_state.dart';
import 'package:test_koesnadi/presentation/home/widgets/card_notes.dart';
import 'package:test_koesnadi/presentation/home/widgets/profile_card.dart';
import 'package:test_koesnadi/presentation/notes/views/add_notes_view.dart';
import 'package:test_koesnadi/presentation/notes/views/detail_note_view.dart';
import 'package:test_koesnadi/presentation/profile/views/profile_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => GetNotesCubit()..displayNotes(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileCard(nextPage: ProfileView(), icon: Icons.person),
                  ProfileCard(nextPage: AddNotesView(), icon: Icons.add),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The only way to do great work is to love what you do.',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.tertiary,
                      ),
                    ),
                    SizedBox(height: height * 0.035),
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.6,
                      child: BlocBuilder<GetNotesCubit, GetNotesState>(
                        builder: (context, state) {
                          if (state is GetNotesLoading) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (state is GetNotesLoaded) {
                            return state.notes.isEmpty
                                ? Container()
                                : ListView.separated(
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onTap: () => AppNavigator.push(
                                        context,
                                        DetailNoteView(
                                          notes: state.notes[index],
                                        ),
                                      ),
                                      child: CardNotes(
                                        notes: state.notes[index],
                                      ),
                                    ),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: height * 0.01,
                                    ),
                                    itemCount: state.notes.length,
                                    scrollDirection: Axis.vertical,
                                  );
                          }
                          if (state is GetNotesFail) {
                            return Center(
                              child: Text(state.errorMessage),
                            );
                          }
                          return Text('halo');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
