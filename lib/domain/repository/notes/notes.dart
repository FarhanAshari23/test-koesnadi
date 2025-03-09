import 'package:dartz/dartz.dart';
import 'package:test_koesnadi/data/model/notes/notes.dart';
import 'package:test_koesnadi/domain/entities/notes/notes.dart';

abstract class NotesRepository {
  Future<Either> getNotes();
  Future<Either> createNotes(NotesModel addNotesReq);
  Future<Either> deleteNotes(String uidNote);
  Future<Either> editNotes(NotesEntity updateNoteReq);
}
