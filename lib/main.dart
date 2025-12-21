import 'package:flutter/material.dart';
import 'screens/home/home.dart';


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
      home: const HomeScreen(),

      // 🔁 បើអ្នកចង់ចាប់ផ្តើមពី Login Screen
      // home: const LoginScreen(),
    );
  }
}
