import 'package:flutter_bloc/flutter_bloc.dart';

class ColorCubit extends Cubit<int> {
  ColorCubit() : super(4294967295);

  void changeColor(int newValue) {
    emit(newValue);
  }
}

class IconCubit extends Cubit<int> {
  IconCubit() : super(61703);

  void changeIcon(int newValue) {
    emit(newValue);
  }
}
