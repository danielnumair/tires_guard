import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'core/theme/app_colors.dart';

void main() {
  runApp(const TiresGuardApp());
}

class TiresGuardApp extends StatelessWidget {
  const TiresGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: AppColors.background,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: AppColors.white),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}