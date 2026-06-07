// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; 

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Đã xóa chữ const ở đây để triệt để lỗi biên dịch
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Terratune',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LoginScreen(), // Giữ const ở đây vì LoginScreen đã có cấu trúc const chuẩn
    );
  }
}