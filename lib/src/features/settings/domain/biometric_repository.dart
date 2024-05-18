import 'package:cent/src/core/utils/cache_helper.dart';
import 'package:local_auth/local_auth.dart';

enum AuthState{
  waiting,
  authenticated,
  unauthenticated,
  error,
}

class BiometricRepository {
  final LocalAuthentication auth = LocalAuthentication();

  Future<AuthState> checkBiometrics({bool value = false}) async {

    final authAvailable = await auth.canCheckBiometrics;
    final  requireAuth = value || CacheHelper.getBool('biometric');
    if(requireAuth == false) return AuthState.authenticated;
    await auth.stopAuthentication();
    if(authAvailable){
      final  biometricsOnly = await auth.canCheckBiometrics;
      return (await auth.authenticate(
        localizedReason: 'Cent needs to verify its you',
        options: AuthenticationOptions(biometricOnly: biometricsOnly),
      )) ? AuthState.authenticated : AuthState.unauthenticated;
    }
    return AuthState.waiting;
  }

}
