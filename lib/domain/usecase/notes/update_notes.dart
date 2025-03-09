import 'package:dartz/dartz.dart';
import 'package:test_koesnadi/domain/entities/notes/notes.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repository/notes/notes.dart';

class UpdateNotesUseCase implements Usecase<Either, NotesEntity> {
  @override
  Future<Either> call({NotesEntity? params}) async {
    return await sl<NotesRepository>().editNotes(params!);
  }
}
