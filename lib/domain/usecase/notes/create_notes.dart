import 'package:dartz/dartz.dart';
import 'package:test_koesnadi/data/model/notes/notes.dart';
import 'package:test_koesnadi/domain/repository/notes/notes.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';

class CreateNotesUseCase implements Usecase<Either, NotesModel> {
  @override
  Future<Either> call({NotesModel? params}) async {
    return await sl<NotesRepository>().createNotes(params!);
  }
}
