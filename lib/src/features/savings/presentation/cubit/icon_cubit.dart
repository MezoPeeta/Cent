
import 'package:flutter_bloc/flutter_bloc.dart';

class IconCubit extends Cubit<int> {
  IconCubit() : super(61703);

  void changeIcon(int newValue) {
    emit(newValue);
  }
}
