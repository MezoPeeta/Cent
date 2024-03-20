import 'package:flutter_bloc/flutter_bloc.dart';

class ColorCubit extends Cubit<int> {
  ColorCubit() : super(0);

  void changeColor(int newValue) {
    emit(newValue);
  }

}

class IconCubit extends Cubit<int> {
  IconCubit() : super(0);

  void changeIcon(int newValue) {
    emit(newValue);
  }

}
