import 'package:flutter/material.dart';
import 'screens/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Luxeshop',
      theme: ThemeData(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),

      // 👉 ចាប់ផ្តើម App នៅ Home Page
      home: const LoginScreen(),
    );
  }
}
