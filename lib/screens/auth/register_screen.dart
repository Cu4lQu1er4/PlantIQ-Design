import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plantiq/main.dart';
import './login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final url = Uri.parse('http://127.0.0.1:8000/api/register/'); // Ajusta si tu endpoint es diferente
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "first_name": _nombresController.text.trim(),
        "last_name": _apellidosController.text.trim(),
        "email": _emailController.text.trim(),
        "password": _passwordController.text.trim(),
        "password2": _confirmpasswordController.text.trim(),
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 201) {
      // Registro exitoso
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      try {
        final data = jsonDecode(response.body);
        setState(() {
          _errorMessage = data.toString();
        });
      } catch (_) {
        setState(() {
          _errorMessage = "Error desconocido en el servidor";
        });
      }
    }
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
              height: 1500,
              padding: const EdgeInsets.all(40),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PaginaInicio()),
                        );
                      },
                      child: Image.asset(
                        'assets/images/Logo.png',
                        width: 400,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Registro de usuario',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFE3E3E3),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),

                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),

                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // nombres
                          TextFormField(
                            controller: _nombresController,
                            style: const TextStyle(color: Color(0xFFE3E3E3)),
                            decoration: _inputDecoration('Nombres', Icons.person),
                            validator: (value) =>
                                value!.isEmpty ? 'Por favor ingresa tus nombres' : null,
                          ),
                          const SizedBox(height: 30),
                          // apellidos
                          TextFormField(
                            controller: _apellidosController,
                            style: const TextStyle(color: Color(0xFFE3E3E3)),
                            decoration: _inputDecoration('Apellidos', Icons.person),
                            validator: (value) =>
                                value!.isEmpty ? 'Por favor ingresa tus apellidos' : null,
                          ),
                          const SizedBox(height: 30),
                          // email
                          TextFormField(
                            controller: _emailController,
                            style: const TextStyle(color: Color(0xFFE3E3E3)),
                            decoration: _inputDecoration('Correo electrónico', Icons.email),
                            validator: (value) {
                              if (value!.isEmpty) return 'Por favor ingresa tu correo';
                              if (!value.contains('@')) return 'Correo inválido';
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          // password
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            style: const TextStyle(color: Color(0xFFE3E3E3)),
                            decoration: _inputDecoration('Contraseña', Icons.password),
                            validator: (value) {
                              if (value!.isEmpty) return 'Por favor ingresa tu contraseña';
                              if (value.length < 6) return 'Mínimo 6 caracteres';
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          // confirm password
                          TextFormField(
                            controller: _confirmpasswordController,
                            obscureText: true,
                            style: const TextStyle(color: Color(0xFFE3E3E3)),
                            decoration: _inputDecoration('Confirma tu contraseña', Icons.password),
                            validator: (value) {
                              if (value!.isEmpty) return 'Por favor confirma la contraseña';
                              if (value != _passwordController.text) {
                                return 'Las contraseñas no coinciden';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 40),
                          // botón
                          Center(
                            child: GestureDetector(
                              onTap: _isLoading ? null : _submitForm,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFDA00FF),
                                      Color(0xFF7E0FF5),
                                      Color(0xFFDA00FF)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: _isLoading
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : const Text(
                                        'Registrar',
                                        style: TextStyle(
                                          color: Color(0xFFE3E3E3),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // enlace
                          Center(
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  color: Color(0xFFE3E3E3),
                                  fontSize: 16,
                                ),
                                children: [
                                  const TextSpan(
                                      text: 'Si ya te has inscrito inicia sesión '),
                                  WidgetSpan(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const LoginScreen()),
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
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFFE3E3E3)),
      filled: true,
      fillColor: const Color(0xFF1C1F2A),
      prefixIcon: Icon(icon, color: const Color(0xFFE3E3E3)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
    );
  }
}
