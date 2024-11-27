import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';  // Importar para abrir enlaces

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5C9D7), // Color del AppBar
        title: const Text(
          "Mi Perfil",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Imagen de perfil
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/foto.png'), // Imagen predeterminada
              ),
              const SizedBox(height: 20),

              // Nombre completo
              Text(
                'Juan Pérez', // Cambiar según el nombre del usuario
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Correo electrónico
              GestureDetector(
                onTap: () {
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'juan.perez@example.com', // Correo de ejemplo
                  );
                  launch(emailLaunchUri.toString());
                },
                child: Text(
                  'juan.perez@example.com',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Teléfono
              GestureDetector(
                onTap: () {
                  final Uri phoneLaunchUri = Uri(
                    scheme: 'tel',
                    path: '+1234567890', // Número de teléfono de ejemplo
                  );
                  launch(phoneLaunchUri.toString());
                },
                child: Text(
                  '+1234567890',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // GitHub
              GestureDetector(
                onTap: () {
                  final Uri gitHubUri = Uri.parse('https://github.com/juanperez'); // Enlace a GitHub
                  launch(gitHubUri.toString());
                },
                child: Text(
                  'https://github.com/juanperez', // Enlace de GitHub de ejemplo
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
