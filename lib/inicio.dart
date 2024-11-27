import 'package:flutter/material.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';  // Importar url_launcher
import 'package:proyecto/perfil.dart';  // Asegúrate de que el archivo de perfil está importado correctamente

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Packages Test',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const InicioPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  var selectedDate = DateTime.now();

  // Datos de ejemplo de las clases para cada día
  Map<DateTime, List<Map<String, String>>> classSchedule = {
    DateTime(2024, 11, 25): [
      {"class": "Barre Reformer", "instructor": "Pau Juarez", "time": "07:15 AM", "duration": "50 min", "status": "Available"},
      {"class": "Barre Reformer", "instructor": "Luis Pérez", "time": "09:00 AM", "duration": "60 min", "status": "3/10"},
      {"class": "Barre Reformer", "instructor": "Pau Juarez", "time": "11:00 AM", "duration": "60 min", "status": "5/10"},
      {"class": "Barre Reformer", "instructor": "Luis Pérez", "time": "12:00 PM", "duration": "60 min", "status": "10/10"},
    ],
    DateTime(2024, 11, 26): [
      {"class": "Barre Reformer", "instructor": "Yvette Rodríguez", "time": "07:15 AM", "duration": "50 min", "status": "Available"},
      {"class": "Barre Reformer", "instructor": "Ana Martínez", "time": "10:00 AM", "duration": "45 min", "status": "5/12"},
      {"class": "Barre Reformer", "instructor": "Carlos Gómez", "time": "12:00 PM", "duration": "50 min", "status": "6/6"},
      {"class": "Barre Reformer", "instructor": "Carlos Gómez", "time": "1:00 PM", "duration": "50 min", "status": "6/6"},
    ],
    // Otros días...
  };

  // Método para abrir la ubicación en Google Maps
  _launchMaps() async {
    final String url = 'https://www.google.com/maps?q=Av.+Irrigacion+550,+Gobernadores,+38035+Celaya,+Gto.';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir la ubicación en Maps';
    }
  }

  // Método para mostrar la ventana emergente con detalles de la clase y botón de pago
  _showClassDetails(BuildContext context, Map<String, String> classInfo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles de la clase: ${classInfo['class']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Instructor: ${classInfo['instructor']}'),
              Text('Hora: ${classInfo['time']}'),
              Text('Duración: ${classInfo['duration']}'),
              Text('Estado: ${classInfo['status']}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cerrar el diálogo
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Cerrar el diálogo
                // Aquí iría la lógica de pago
                _showPaymentConfirmation(context);
              },
              child: const Text('Pagar'),
            ),
          ],
        );
      },
    );
  }

  // Método para mostrar la ventana emergente de confirmación de pago
  _showPaymentConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación de pago'),
          content: const Text('¡Pago realizado exitosamente!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cerrar el diálogo
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5C9D7), // Azul negro
        title: const Text(
          "Reserva tus clases",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white, // Fondo blanco del Scaffold
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              HorizontalWeekCalendar(
                minDate: DateTime(2024, 1, 1), // Fecha mínima
                maxDate: DateTime(2024, 12, 31), // Fecha máxima
                initialDate: DateTime.now(), // Fecha inicial
                onDateChange: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
                showTopNavbar: false,
                monthFormat: "MMMM yyyy",
                showNavigationButtons: true,
                weekStartFrom: WeekStartFrom.Monday,
                borderRadius: BorderRadius.circular(7),
                activeBackgroundColor: const Color(0xFF0B1B32), // Azul negro
                activeTextColor: const Color(0xFFE5C9D7), // Rosa pastel
                inactiveBackgroundColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3), // Azul mate
                inactiveTextColor: const Color(0xFFE5C9D7), // Rosa pastel
                disabledTextColor: Colors.grey,
                disabledBackgroundColor: Colors.white,
                activeNavigatorColor: const Color(0xFF0B1B32), // Azul negro
                inactiveNavigatorColor: const Color(0xFF26415E), // Azul mate
                monthColor: const Color(0xFF0B1B32), // Azul negro
              ),
              const SizedBox(height: 20),
              Expanded(
                child: classSchedule[selectedDate] != null && classSchedule[selectedDate]!.isNotEmpty
                    ? ListView.builder(
                        itemCount: classSchedule[selectedDate]!.length,
                        itemBuilder: (context, index) {
                          var classInfo = classSchedule[selectedDate]![index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(classInfo['class']!),
                              subtitle: Text("${classInfo['instructor']} - ${classInfo['time']} (${classInfo['duration']})"),
                              trailing: Text(classInfo['status']!),
                              // Botón de reservar
                              onTap: () {
                                _showClassDetails(context, classInfo); // Mostrar detalles al hacer click
                              },
                            ),
                          );
                        },
                      )
                    : Center(child: Text('No hay clases para este día')),
              ),
              // Botón de ubicación en la parte inferior
              GestureDetector(
                onTap: _launchMaps,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF26415E), Color(0xFF0B1B32)], // Gradiente de azul mate y azul oscuro
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30), // Bordes redondeados
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 6,
                        offset: const Offset(0, 3), // Sombra ligera
                      ),
                    ],
                  ),
                  child: const Text(
                    'Ubicación',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFE5C9D7),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  PerfilPage()), // Navegar a la página de perfil
            );
          }
        },
      ),
    );
  }
}
