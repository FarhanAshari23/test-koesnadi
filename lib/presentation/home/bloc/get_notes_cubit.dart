import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_koesnadi/domain/usecase/notes/get_notes.dart';
import 'package:test_koesnadi/presentation/home/bloc/get_notes_state.dart';

import '../../../service_locator.dart';

class GetNotesCubit extends Cubit<GetNotesState> {
  GetNotesCubit() : super(GetNotesLoading());

  void displayNotes() async {
    var returnedData = await sl<GetNotesUseCase>().call();
    returnedData.fold(
      (error) {
        return emit(GetNotesFail(errorMessage: error));
      },
      (data) {
        return emit(GetNotesLoaded(notes: data));
      },
    );
  }
}
