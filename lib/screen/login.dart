import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:proyecto/onboarding.dart';
import 'package:url_launcher/url_launcher.dart';
  // Asegúrate de importar el archivo de onboarding

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  // Función para redirigir al onboarding
  void _navigateToOnboarding(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  OnboardingPage()),
    );
  }

  // Función para abrir enlaces
  Future<void> _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('No se pudo abrir el enlace: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterLogin(
            title: 'B   i   e   n   v   e   n   i   d   o   s ',
            logo: const AssetImage('pilates.png'), // Cambia a tu logo
            onLogin: (_) async {
              // Validación de los campos de login
              if ((_.name?.isEmpty ?? true) || (_.password?.isEmpty ?? true)) {
                return 'Por favor, completa todos los campos.';
              }
              // Redirigir al onboarding
              _navigateToOnboarding(context);
              return null;
            },
            onSignup: (_) async {
              // Validación de los campos en el registro
              if ((_.name?.isEmpty ?? true) || (_.password?.isEmpty ?? true)) {
                return 'Por favor, completa todos los campos.';
              }
              // Redirigir al onboarding
              _navigateToOnboarding(context);
              return null;
            },
            onRecoverPassword: (_) async {
              return 'Función no habilitada actualmente.';
            },
            theme: LoginTheme(
              primaryColor: const Color.fromARGB(255, 248, 248, 248),
              accentColor: const Color(0xFF26415E),
              cardTheme: const CardTheme(
                color: Color(0xFFE5C9D7),
              ),
              buttonTheme: LoginButtonTheme(
                backgroundColor: const Color(0xFF26415E),
              ),
              titleStyle: const TextStyle(
                color: Color(0xFF83A6CE),
                fontSize: 24,
              ),
            ),
          ),
          // Botones de redes sociales
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Inicia sesión con:',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(
                      icon: Icons.g_mobiledata,
                      color: const Color(0xFF83A6CE), // Baby blue
                      onPressed: () => _openUrl("https://accounts.google.com/"),
                    ),
                    const SizedBox(width: 10),
                    _buildSocialButton(
                      icon: Icons.facebook,
                      color: const Color(0xFF26415E), // Azul mate
                      onPressed: () => _openUrl("https://www.facebook.com/"),
                    ),
                    const SizedBox(width: 10),
                    _buildSocialButton(
                      icon: Icons.code,
                      color: const Color(0xFF0B1B32), // Azul negro
                      onPressed: () => _openUrl("https://github.com/login"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: color,
        child: Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
