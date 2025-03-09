import 'package:get_it/get_it.dart';
import 'package:test_koesnadi/data/repository/notes/notes_repository_impl.dart';
import 'package:test_koesnadi/data/sources/notes/notes_firebase_service.dart';
import 'package:test_koesnadi/domain/repository/notes/notes.dart';
import 'package:test_koesnadi/domain/usecase/auth/edit_user.dart';
import 'package:test_koesnadi/domain/usecase/notes/create_notes.dart';
import 'package:test_koesnadi/domain/usecase/notes/delete_note.dart';
import 'package:test_koesnadi/domain/usecase/notes/get_notes.dart';
import 'package:test_koesnadi/domain/usecase/notes/update_notes.dart';

import 'data/repository/auth/auth_repository_impl.dart';
import 'data/sources/auth/auth_firebase_service.dart';
import 'domain/repository/auth/auth.dart';
import 'domain/usecase/auth/get_user.dart';
import 'domain/usecase/auth/is_logged_in.dart';
import 'domain/usecase/auth/signin.dart';
import 'domain/usecase/auth/signup.dart';

final sl = GetIt.instance;

Future<void> initializeDependecies() async {
  //service
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl(),
  );
  sl.registerSingleton<NotesFirebaseService>(
    NotesFirebaseServiceImpl(),
  );

  //repository
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(),
  );
  sl.registerSingleton<NotesRepository>(
    NotesRepositoryImpl(),
  );

  //usecase

  //user
  sl.registerSingleton<SignInUsecase>(
    SignInUsecase(),
  );
  sl.registerSingleton<GetUserUsecase>(
    GetUserUsecase(),
  );

  sl.registerSingleton<SignUpUseCase>(
    SignUpUseCase(),
  );
  sl.registerSingleton<IsLoggedInUsecase>(
    IsLoggedInUsecase(),
  );
  sl.registerSingleton<EditUserUseCase>(
    EditUserUseCase(),
  );

  //notes
  sl.registerSingleton<CreateNotesUseCase>(
    CreateNotesUseCase(),
  );
  sl.registerSingleton<GetNotesUseCase>(
    GetNotesUseCase(),
  );
  sl.registerSingleton<DeleteNoteUseCase>(
    DeleteNoteUseCase(),
  );
  sl.registerSingleton<UpdateNotesUseCase>(
    UpdateNotesUseCase(),
  );
}
