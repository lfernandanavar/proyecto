import 'package:flutter/material.dart';
import 'package:proyecto/screen/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFF0B1B23),
        scaffoldBackgroundColor: const Color(0xFF0B1B23),
      ),
      home: const LoginPage(),
    );
  }
}
