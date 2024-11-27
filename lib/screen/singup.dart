import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1B23),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0B1B23),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Center(
        child: Text(
          "Pantalla de Registro",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
