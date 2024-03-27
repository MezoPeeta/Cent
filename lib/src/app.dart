import 'package:cent/src/core/routes/routes.dart';
import 'package:cent/src/core/theme/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
    );
  }
}
