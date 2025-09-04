import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SystemTap extends StatefulWidget {
  const SystemTap({super.key});

  @override
  _SystemTapState createState() => _SystemTapState();
}

class _SystemTapState extends State<SystemTap> {
  final TextEditingController nombreCultivoController = TextEditingController();
  final TextEditingController tipoCultivoController = TextEditingController();

  int? numeroLotes;
  int? numeroAspersoresPorLote;
  int? numeroCamasPorLote;

  String? duracion;
  String? inicio;

  final List<String> tiemposRiego = ['15 min', '30 min', '45 min', '60 min'];

  @override
  void dispose() {
    nombreCultivoController.dispose();
    tipoCultivoController.dispose();
    super.dispose();
  }

  Future<void> enviarCultivo() async {
    final String token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU2Njk0MDU3LCJpYXQiOjE3NTY2OTM3NTcsImp0aSI6Ijk2MWJlYTIwMzU2OTQ1ZGZiZWI5YTgzOWRmYzAzZjE4IiwidXNlcl9pZCI6ImQ0OWE2OTkzLWFiZWUtNGZhMi04YWY2LTJhMDA3ZTUzODY2YiJ9.SecVSv2Hf43XQEHwWDhWZtgixTA9p1IEFYgBmvcF5ic';
    final url = Uri.parse(
      'http://127.0.0.1:8000/api/cultivos/',
    ); // Cambia por tu IP y endpoint

    final body = {
      'nombre_cultivo': nombreCultivoController.text.trim(),
      'tipo_cultivo': tipoCultivoController.text.trim(),
      'numero_lotes': numeroLotes ?? 1,
      'numero_aspersores_por_lote': numeroAspersoresPorLote ?? 1,
      'numero_camas_por_lote': numeroCamasPorLote ?? 1,
      'duracion_riego': duracion ?? tiemposRiego[0],
      'inicio_riego': inicio ?? tiemposRiego[0],
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cultivo guardado en el servidor')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al guardar cultivo: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error de conexión: $e')));
    }
  }

  void guardarDatos() {
    String nombre = nombreCultivoController.text.trim();
    String tipo = tipoCultivoController.text.trim();

    if (nombre.isEmpty || tipo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor completa los campos obligatorios'),
        ),
      );
      return;
    }

    print('Nombre Cultivo: $nombre');
    print('Tipo de cultivo: $tipo');
    print('Número de lotes: $numeroLotes');
    print('Número de aspersores por lote: $numeroAspersoresPorLote');
    print('Número de camas por lote: $numeroCamasPorLote');
    print('Inicio riego: $inicio');
    print('Duracion riego: $duracion');

    enviarCultivo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F2A),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ===== FORMULARIO PRINCIPAL =====
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2B2F3A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Registro de Cultivos",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFFE3E3E3),
                            ),
                          ),
                          const SizedBox(height: 17),
                          TextField(
                            controller: nombreCultivoController,
                            style: const TextStyle(color: Color(0xFFE3E3E3)),
                            cursorColor: const Color(0xFFE3E3E3),
                            decoration: InputDecoration(
                              labelText: "Nombre Cultivo",
                              labelStyle: const TextStyle(
                                color: Color(0xFFE3E3E3),
                              ),
                              filled: true,
                              fillColor: const Color(0xFF1C1F2A),
                              prefixIcon: const Icon(
                                Icons.grass,
                                color: Color(0xFFE3E3E3),
                                size: 20,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 13),
                          TextField(
                            controller: tipoCultivoController,
                            style: const TextStyle(color: Color(0xFFE3E3E3)),
                            cursorColor: const Color(0xFFE3E3E3),
                            decoration: InputDecoration(
                              labelText: "Tipo de cultivo",
                              labelStyle: const TextStyle(
                                color: Color(0xFFE3E3E3),
                              ),
                              filled: true,
                              fillColor: const Color(0xFF1C1F2A),
                              prefixIcon: const Icon(
                                Icons.eco,
                                color: Color(0xFFE3E3E3),
                                size: 20,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Registro de lotes y tiempos de riego
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2B2F3A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Registro de lotes del cultivos",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE3E3E3),
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 17),

                          DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              labelText: "Número de lotes",
                              labelStyle: const TextStyle(
                                color: Color(0xFFE3E3E3),
                              ),
                              filled: true,
                              fillColor: const Color(0xFF1C1F2A),
                              prefixIcon: const Icon(
                                Icons.numbers,
                                color: Color(0xFFE3E3E3),
                                size: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            dropdownColor: const Color(0xFF2B2F3A),
                            style: const TextStyle(color: Color(0xFFE3E3E3)),
                            items: List.generate(10, (index) => index + 1)
                                .map(
                                  (e) => DropdownMenuItem<int>(
                                    value: e,
                                    child: Text(e.toString()),
                                  ),
                                )
                                .toList(),
                            value: numeroLotes,
                            onChanged: (value) {
                              setState(() {
                                numeroLotes = value;
                              });
                            },
                          ),

                          const SizedBox(height: 20),

                          DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              labelText: "Número de aspersores por lote",
                              labelStyle: const TextStyle(
                                color: Color(0xFFE3E3E3),
                              ),
                              filled: true,
                              fillColor: const Color(0xFF1C1F2A),
                              prefixIcon: const Icon(
                                Icons.numbers,
                                color: Color(0xFFE3E3E3),
                                size: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            dropdownColor: const Color(0xFF2B2F3A),
                            style: const TextStyle(color: Color(0xFFE3E3E3)),
                            items: List.generate(10, (index) => index + 1)
                                .map(
                                  (e) => DropdownMenuItem<int>(
                                    value: e,
                                    child: Text(e.toString()),
                                  ),
                                )
                                .toList(),
                            value: numeroAspersoresPorLote,
                            onChanged: (value) {
                              setState(() {
                                numeroAspersoresPorLote = value;
                              });
                            },
                          ),

                          const SizedBox(height: 20),

                          DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              labelText: "Número de camas por lote",
                              labelStyle: const TextStyle(
                                color: Color(0xFFE3E3E3),
                              ),
                              filled: true,
                              fillColor: const Color(0xFF1C1F2A),
                              prefixIcon: const Icon(
                                Icons.numbers,
                                color: Color(0xFFE3E3E3),
                                size: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            dropdownColor: const Color(0xFF2B2F3A),
                            style: const TextStyle(color: Color(0xFFE3E3E3)),
                            items: List.generate(10, (index) => index + 1)
                                .map(
                                  (e) => DropdownMenuItem<int>(
                                    value: e,
                                    child: Text(e.toString()),
                                  ),
                                )
                                .toList(),
                            value: numeroCamasPorLote,
                            onChanged: (value) {
                              setState(() {
                                numeroCamasPorLote = value;
                              });
                            },
                          ),

                          const SizedBox(height: 20),

                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: "Duracion riego (en minutos)",
                              labelStyle: const TextStyle(
                                color: Color(0xFFE3E3E3),
                              ),
                              filled: true,
                              fillColor: const Color(0xFF1C1F2A),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            dropdownColor: const Color(0xFF2B2F3A),
                            style: const TextStyle(color: Color(0xFFE3E3E3)),
                            items: tiemposRiego
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                            value: duracion,
                            onChanged: (value) {
                              setState(() {
                                duracion = value;
                              });
                            },
                          ),

                          const SizedBox(height: 20),

                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: "Inicio Riego",
                              labelStyle: const TextStyle(
                                color: Color(0xFFE3E3E3),
                              ),
                              filled: true,
                              fillColor: const Color(0xFF1C1F2A),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            dropdownColor: const Color(0xFF2B2F3A),
                            style: const TextStyle(color: Color(0xFFE3E3E3)),
                            items: tiemposRiego
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                            value: inicio,
                            onChanged: (value) {
                              setState(() {
                                inicio = value;
                              });
                            },
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    ElevatedButton(
                      onPressed: guardarDatos,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF04A14E),
                        fixedSize: const Size(100, 35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text("Guardar"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}