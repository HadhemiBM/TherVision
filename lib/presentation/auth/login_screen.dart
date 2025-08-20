import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerBtn,
      body: Center(
        child: Text(
          "LOGIN",
          style: TextStyle(fontSize: 40, color: AppColors.primary),
        ),
      ),
    );
  }
}
