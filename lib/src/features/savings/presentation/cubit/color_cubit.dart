import 'package:flutter_bloc/flutter_bloc.dart';

class ColorCubit extends Cubit<int> {
  ColorCubit() : super(4294967295);

  void changeColor(int newValue) {
    emit(newValue);
  }
}

