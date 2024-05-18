import 'package:cent/src/core/utils/cache_helper.dart';
import 'package:cent/src/features/settings/domain/biometric_repository.dart';
import 'package:flutter/material.dart';

class InitBiometric extends StatefulWidget {
  const InitBiometric({required this.child, super.key});
  final Widget child;

  @override
  State<InitBiometric> createState() => _InitBiometricState();
}

class _InitBiometricState extends State<InitBiometric> {
  AuthState authState = AuthState.waiting;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,()async{
      await _checkBiometric();
    });
  }

  Future<void> _checkBiometric() async{
    final state = await BiometricRepository().checkBiometrics();
    setState(() {
      authState = state;
    });
  }

  bool requireAuth = CacheHelper.getBool('biometric');
  @override
  Widget build(BuildContext context) {
    if(authState == AuthState.authenticated || requireAuth == false) return widget.child;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: (){
          setState(() {
            authState = AuthState.waiting;
          });
          _checkBiometric();
        },
        child: Center(child: authState != AuthState.waiting ? const Icon(Icons.lock_outline):const SizedBox.shrink()),
      ),

    );
  }
}
