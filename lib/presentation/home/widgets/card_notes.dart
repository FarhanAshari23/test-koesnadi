import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:test_koesnadi/common/helper/app_navigation.dart';
import 'package:test_koesnadi/domain/entities/notes/notes.dart';
import 'package:test_koesnadi/domain/usecase/notes/delete_note.dart';
import 'package:test_koesnadi/presentation/home/views/home_view.dart';
import 'package:test_koesnadi/presentation/notes/views/edit_notes_view.dart';

import '../../../common/widgets/button/basic_button.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../service_locator.dart';

class CardNotes extends StatelessWidget {
  final NotesEntity notes;
  const CardNotes({
    super.key,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final timestamp = notes.createdAt;
    final DateTime dateTime = timestamp.toDate();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(dateTime);
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) =>
                AppNavigator.push(context, EditNotesView(notes: notes)),
            icon: Icons.edit,
            backgroundColor: Colors.green,
          ),
          SlidableAction(
            onPressed: (context) async {
              return showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: AppColors.inversePrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SizedBox(
                      width: width * 0.7,
                      height: height * 0.55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: width * 0.6,
                            height: height * 0.3,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppImages.splashDelete),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(
                            'Are you sure want to delete this note?',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: height * 0.02),
                          BasicButton(
                            onPressed: () async {
                              var delete = await sl<DeleteNoteUseCase>()
                                  .call(params: notes.code);
                              return delete.fold(
                                (error) {
                                  var snackbar = const SnackBar(
                                    content: Text("Failed to delete note data"),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                },
                                (r) {
                                  var snackbar = const SnackBar(
                                    content: Text("Succes delete note"),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                  AppNavigator.push(context, HomeView());
                                },
                              );
                            },
                            title: 'Delete',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        height: height * 0.175,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          color: AppColors.secondary,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: height * 0.025),
              SizedBox(
                width: width * 0.8,
                height: height * 0.085,
                child: Text(
                  notes.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
