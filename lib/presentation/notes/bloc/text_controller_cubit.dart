import 'package:flutter_bloc/flutter_bloc.dart';

import 'text_controller_state.dart';

class TextCubit extends Cubit<TextState> {
  TextCubit() : super(TextState(''));

  void updateText(String text) {
    emit(TextState(text));
  }
}
