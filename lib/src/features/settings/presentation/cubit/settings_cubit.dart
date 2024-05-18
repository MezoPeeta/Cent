import 'package:cent/src/core/utils/cache_helper.dart';
import 'package:cent/src/features/settings/domain/biometric_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BiometricCubit extends Cubit<bool> {
  BiometricCubit() : super(_getDefaultValue());

  static bool _getDefaultValue() {
    final value = CacheHelper.getBool('biometric');
    return value;
  }

  void changeValue({required bool value}) {
    emit(value);
    CacheHelper.setBool('biometric', value: value);
    BiometricRepository().checkBiometrics(value: value);
  }


}
