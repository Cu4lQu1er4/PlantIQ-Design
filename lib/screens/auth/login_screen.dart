// lib/screens/auth/login_screen.dart

import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'package:plantiq/main.dart';
import '../dashboard/dashboard_screen.dart';

// Añadido para la petición HTTP y manejo JSON
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Cambié esta función para que haga la petición POST al backend
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      try {
        final response = await http.post(
          Uri.parse(
            'http://127.0.0.1:8000/api/login/',
          ), // <--- Cambia esta URL por la de tu backend
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'email': email, 'password': password}),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final accessToken = data['access'];
          final refreshToken = data['refresh'];

          if (accessToken != null) {
            // Aquí podrías guardar los tokens en almacenamiento local si quieres

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          } else {
            _showErrorDialog('No se recibió token de acceso.');
          }
        } else {
          final errorData = json.decode(response.body);
          String errorMessage = 'Error al iniciar sesión.';

          if (errorData.containsKey('email')) {
            errorMessage = errorData['email'].toString();
          } else if (errorData.containsKey('password')) {
            errorMessage = errorData['password'].toString();
          } else if (errorData.containsKey('detail')) {
            errorMessage = errorData['detail'].toString();
          }

          _showErrorDialog(errorMessage);
        }
      } catch (e) {
        _showErrorDialog('Error de conexión con el servidor.');
      }
    }
  }

  // Función para mostrar un diálogo con error
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error de inicio de sesión'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F2A),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2B2F3A),
                borderRadius: BorderRadius.circular(20),
              ),
              width: 600,
              height: 600,
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaginaInicio(),
                        ),
                      );
                    },
                    child: Image.asset('assets/images/Logo.png', width: 400),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Inicio de sesión',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFE3E3E3),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //email
                        TextFormField(
                          controller: _emailController,
                          style: const TextStyle(color: Color(0xFFE3E3E3)),
                          decoration: InputDecoration(
                            labelText: 'Correo electronico',
                            labelStyle: const TextStyle(
                              color: Color(0xFFE3E3E3),
                            ),
                            filled: true,
                            fillColor: const Color(0xFF1C1F2A),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Color(0xFFE3E3E3),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa tu correo';
                            }
                            if (!value.contains('@')) {
                              return 'Correo inválido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        //password
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          style: const TextStyle(color: Color(0xFFE3E3E3)),
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            labelStyle: const TextStyle(
                              color: Color(0xFFE3E3E3),
                            ),
                            filled: true,
                            fillColor: const Color(0xFF1C1F2A),
                            prefixIcon: const Icon(
                              Icons.password,
                              color: Color(0xFFE3E3E3),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa tu contraseña';
                            }
                            if (value.length < 6) {
                              return 'Minimo 6 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),
                        //boton
                        Center(
                          child: GestureDetector(
                            onTap: _submitForm,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 35,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFDA00FF),
                                    Color(0xFF7E0FF5),
                                    Color(0xFFDA00FF),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'Iniciar sesión',
                                style: TextStyle(
                                  color: Color(0xFFE3E3E3),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //enlace
                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                color: Color(0xFFE3E3E3),
                                fontSize: 16,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Si no te has inscrito registrate ',
                                ),
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterScreen(),
                                        ),
                                      );
                                    },
                                    child: ShaderMask(
                                      shaderCallback: (bounds) =>
                                          const LinearGradient(
                                            colors: [
                                              Color(0xFFDA00FF),
                                              Color(0xFF7E0FF5),
                                              Color(0xFFDA00FF),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ).createShader(bounds),
                                      child: const Text(
                                        'aquí.',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
