// lib/main.dart
// Điểm khởi động ứng dụng Terratune
// Khởi tạo Firebase, Provider và điều hướng ban đầu

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';


void main() async {
  // Đảm bảo Flutter binding được khởi tạo trước khi dùng async
  WidgetsFlutterBinding.ensureInitialized();



  runApp(const TerratuneApp());
}

class TerratuneApp extends StatelessWidget {
  const TerratuneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Terratune',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
