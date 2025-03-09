import 'package:test_koesnadi/domain/entities/notes/notes.dart';

abstract class GetNotesState {}

class GetNotesLoading extends GetNotesState {}

class GetNotesLoaded extends GetNotesState {
  final List<NotesEntity> notes;

  GetNotesLoaded({required this.notes});
}

class GetNotesFail extends GetNotesState {
  final String errorMessage;

  GetNotesFail({required this.errorMessage});
}
