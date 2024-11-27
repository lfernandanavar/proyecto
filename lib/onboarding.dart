import 'package:flutter/material.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:lottie/lottie.dart';
import 'inicio.dart'; // Asegúrate de importar la página de inicio

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Este color no se utiliza directamente
        scaffoldBackgroundColor: Colors.white, // Fondo blanco
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF0B1B32)), // Azul negro
          bodyMedium: TextStyle(color: Color(0xFF26415E)), // Azul mate
        ),
      ),
      home: OnboardingPage(),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  OnboardingPage({Key? key}) : super(key: key);

  final data = [
    CardPlanetData(
      title: "C o m p r a  t u  M e m b r e c i a",
      subtitle: "",
      image: const AssetImage("pilateso.png"),
      backgroundColor: Color(0xFFE5C9D7), // Rosa pastel
      titleColor: Color(0xFF0B1B32), // Azul negro
      subtitleColor: Color(0xFF26415E), // Azul mate
    ),
    CardPlanetData(
      title: "R e s e r v a  t u  C l a s e s",
      subtitle: "",
      image: const AssetImage("yoga.png"),
      backgroundColor: Color(0xFF83A6CE), // Baby blue
      titleColor: Color(0xFF0B1B32), // Azul negro
      subtitleColor: Color(0xFF26415E), // Azul mate
    ),
    CardPlanetData(
      title: "D i s f r u t a  d e  e l l a s",
      subtitle: "",
      image: const AssetImage("ballet.png"),
      backgroundColor: Color(0xFFC48CB3), // Rosa
      titleColor: Color(0xFF0B1B32), // Azul negro
      subtitleColor: Color(0xFF26415E), // Azul mate
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index) {
          return CardaPlanet(data: data[index]);
        },
        // Redirige al finalizar el onboarding
        onFinish: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const InicioPage()),
          );
        },
      ),
    );
  }
}

class CardPlanetData {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Widget? background;

  const CardPlanetData({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    this.background,
  });
}

class CardaPlanet extends StatelessWidget {
  const CardaPlanet({
    required this.data,
    Key? key,
  }) : super(key: key);

  final CardPlanetData data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (data.background != null) data.background!,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 60),
          child: Column(
            children: [
              const Spacer(flex: 3),
              Flexible(
                flex: 30,
                child: Image(image: data.image),
              ),
              const Spacer(flex: 1),
              Text(
                data.title.toUpperCase(),
                style: TextStyle(
                  color: data.titleColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                maxLines: 1,
              ),
              const Spacer(flex: 1),
              Text(
                data.subtitle,
                style: TextStyle(
                  color: data.subtitleColor,
                  fontSize: 16,
                ),
                maxLines: 2,
              ),
              const Spacer(flex: 5),
            ],
          ),
        ),
      ],
    );
  }
}
