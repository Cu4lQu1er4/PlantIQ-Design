// Importa el paquete principal de Flutter que permite construir interfaces de usuario
import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';

// Función principal: punto de entrada de la aplicación
void main() {
  runApp(const MyApp()); // Ejecuta la app y muestra el widget raíz
}

// Widget principal de la aplicación
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor con clave opcional (recomendado para widgets)

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Página de Inicio', // Título de la app (se usa en algunos entornos)
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de "debug" en la esquina
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2B2F3A)), // Tema de color base
        useMaterial3: true, // Usa el nuevo estilo de diseño Material 3
      ),
      home: const PaginaInicio(), // Página que se mostrará al iniciar la app
    );
  }
}

// Página de inicio que se muestra al arrancar la app
class PaginaInicio extends StatelessWidget {
  const PaginaInicio({super.key}); // Constructor del widget sin estado

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Crea una estructura base con AppBar, body, etc.
      backgroundColor: Color(0xFF1C1F2A), // Color de fondo personalizado (fondo oscuro)
      body: SafeArea( // Evita que el contenido se sobreponga al notch o barra de estado
        child: Center( // Centra su contenido en el eje vertical y horizontal
          child: Padding(
            padding: const EdgeInsets.all(24.0), // Agrega espacio (24px) alrededor del contenido
            child: Container(
              decoration: BoxDecoration(
                color:Color(0xFF2B2F3A),
                borderRadius: BorderRadius.circular(20)
              ),
              height: 400,
              width: 700,
              child: Column( // Organiza los widgets hijos en una columna vertical
                mainAxisAlignment: MainAxisAlignment.center, // Centra los hijos verticalmente
                children: [ // Lista de widgets dentro de la columna

                  // Muestra una imagen (logo) desde los assets
                  Image.asset(
                    'assets/images/Logo.png', // Ruta de la imagen
                    width: 400, // Ancho de la imagen
                  ),

                  const SizedBox(height: 32), // Espacio vertical entre imagen y título

                  // Texto del título principal
                  const Text(
                    '"Agua precisa, tierra productiva."', // Contenido del texto
                    style: TextStyle(
                      fontSize: 20, // Tamaño del texto
                      fontWeight: FontWeight.bold, // Texto en negrita
                      color: Color(0xFFE3E3E3), // Color del texto (casi negro)
                    ),
                  ),

                  const SizedBox(height: 16), // Espacio vertical entre título y subtítulo

                  // Texto descriptivo debajo del título
                  const Text(
                    'Tus cultivos siempre saludables con nuestro sistema de riego inteligente.',
                    textAlign: TextAlign.center, // Centra el texto
                    style: TextStyle(
                      fontSize: 16, // Tamaño del texto
                      color: Color(0xFFE3E3E3), // Color del texto (gris oscuro)
                    ),
                  ),
                  
                  const SizedBox(height: 40), // Espacio vertical antes del botón
                
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFDA00FF), Color(0xFF7E0FF5),Color(0xFFDA00FF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Comenzar',
                        style: TextStyle(
                          color: Color(0xFFE3E3E3),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox( height: 16,),

                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Color(0xFFE3E3E3),
                        fontSize: 16,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Si no te has inscrito registrate '
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: ShaderMask(
                              shaderCallback:(bounds)=> const LinearGradient(
                                colors: [
                                  Color(0xFFDA00FF), 
                                  Color(0xFF7E0FF5),
                                  Color(0xFFDA00FF),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                              child: Text(
                                'aquí.',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          )
                        )
                      ]
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}

