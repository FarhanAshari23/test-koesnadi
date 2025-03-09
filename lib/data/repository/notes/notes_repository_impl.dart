import 'package:dartz/dartz.dart';
import 'package:test_koesnadi/data/model/notes/notes.dart';
import 'package:test_koesnadi/data/sources/notes/notes_firebase_service.dart';
import 'package:test_koesnadi/domain/entities/notes/notes.dart';
import 'package:test_koesnadi/domain/repository/notes/notes.dart';

import '../../../service_locator.dart';

class NotesRepositoryImpl extends NotesRepository {
  @override
  Future<Either> createNotes(NotesModel addNotesReq) async {
    return sl<NotesFirebaseService>().createNotes(addNotesReq);
  }

  @override
  Future<Either> getNotes() async {
    var returnedData = await sl<NotesFirebaseService>().getNotes();
    return returnedData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(
          List.from(data).map((e) => NotesModel.fromMap(e).toEntity()).toList(),
        );
      },
    );
  }

  @override
  Future<Either> deleteNotes(String uidNote) async {
    return sl<NotesFirebaseService>().deleteNotes(uidNote);
  }

  @override
  Future<Either> editNotes(NotesEntity updateNoteReq) async {
    return sl<NotesFirebaseService>().editNotes(updateNoteReq);
  }
}
