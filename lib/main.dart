// lib/main.dart
// Điểm khởi động ứng dụng Terratune
// Khởi tạo Firebase, Provider và điều hướng ban đầu

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

// TODO: Thay bằng file firebase_options.dart tự động sinh từ FlutterFire CLI
// import 'firebase_options.dart';

void main() async {
  // Đảm bảo Flutter binding được khởi tạo trước khi dùng async
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebase
  // Uncomment dòng dưới sau khi chạy: flutterfire configure
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 // await Firebase.initializeApp();

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
