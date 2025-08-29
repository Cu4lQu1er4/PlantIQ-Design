import 'package:flutter/material.dart';

class SystemTap extends StatelessWidget {
  const SystemTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F2A),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ===== FORMULARIO PRINCIPAL =====
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centrar verticalmente el contenido del Column
                crossAxisAlignment: CrossAxisAlignment.center, // Centrar 
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B2F3A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Registro de Cultivos",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xFFE3E3E3)
                          ),
                        ),

                        const SizedBox(height: 17,),

                        TextField(
                          style: const TextStyle(color: Color(0xFFE3E3E3)),
                          cursorColor: Color(0xFFE3E3E3),
                          decoration: InputDecoration(
                            labelText: "Nombre Cultivo",
                            labelStyle: const TextStyle(color: Color(0xFFE3E3E3)),
                            filled: true,
                            fillColor:  Color(0xFF1C1F2A),
                            prefixIcon: Icon(Icons.grass, color: Color(0xFFE3E3E3), size: 20,),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          ),
                        ),

                        const SizedBox(height: 13),
                        
                        TextField(
                          style: const TextStyle(color: Color(0xFFE3E3E3)),
                          cursorColor: Color(0xFFE3E3E3),
                          decoration: InputDecoration(
                            labelText: "Tipo de cultivo",
                            labelStyle: const TextStyle(color: Color(0xFFE3E3E3)),
                            filled: true,
                            fillColor: Color(0xFF1C1F2A),
                            prefixIcon: Icon(Icons.eco, color: Color(0xFFE3E3E3), size: 20,),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Otro contenedor para datos adicionales
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B2F3A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Registro de lotes del cultivos",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE3E3E3),
                            fontSize: 15, 
                          ),
                        ),

                        const SizedBox(height: 17,),
                        // Selector número de lotes
                        DropdownButtonFormField<int>(
                          decoration: InputDecoration(
                            labelText: "Número de lotes",
                            labelStyle: const TextStyle(color: Color(0xFFE3E3E3)),
                            filled: true,
                            fillColor: const Color(0xFF1C1F2A),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          dropdownColor: const Color(0xFF2B2F3A),
                          style: const TextStyle(color: Color(0xFFE3E3E3)),
                          items: List.generate(10, (index) => index + 1)
                              .map((e) => DropdownMenuItem<int>(
                                    value: e,
                                    child: Text(e.toString()),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            // Manejar cambio
                          },
                        ),
                        const SizedBox(height: 20),

                        // Selector número de aspersores por lote
                        DropdownButtonFormField<int>(
                          decoration: InputDecoration(
                            labelText: "Número de apersores por lote",
                            labelStyle: const TextStyle(color: Color(0xFFE3E3E3)),
                            filled: true,
                            fillColor: const Color(0xFF1C1F2A),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none
                              ),
                          ),
                          dropdownColor: const Color(0xFF2B2F3A),
                          style: const TextStyle(color: Color(0xFFE3E3E3)),
                          items: List.generate(10, (index) => index + 1)
                              .map((e) => DropdownMenuItem<int>(
                                    value: e,
                                    child: Text(e.toString()),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            // Manejar cambio
                          },
                        ),
                        const SizedBox(height: 20),

                        // Selector tiempo de riego del día (mañana, tarde, noche)
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "Tiempo de riego (mañana)",
                            labelStyle: const TextStyle(color: Color(0xFFE3E3E3)),
                            filled: true,
                            fillColor: const Color(0xFF1C1F2A),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none
                            ),
                          ),
                          dropdownColor: const Color(0xFF2B2F3A),
                          style: const TextStyle(color: Color(0xFFE3E3E3)),
                          items: [
                            '15 min',
                            '30 min',
                            '45 min',
                            '60 min',
                          ]
                              .map((e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            // Manejar cambio
                          },
                        ),
                        const SizedBox(height: 20),

                        // Lo mismo para la tarde
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "Tiempo de riego (tarde)",
                            labelStyle: const TextStyle(color: Color(0xFFE3E3E3)),
                            filled: true,
                            fillColor: const Color(0xFF1C1F2A),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none
                            ),
                          ),
                          dropdownColor: const Color(0xFF2B2F3A),
                          style: const TextStyle(color: Color(0xFFE3E3E3)),
                          items: [
                            '15 min',
                            '30 min',
                            '45 min',
                            '60 min',
                          ]
                              .map((e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            // Manejar cambio
                          },
                        ),
                        const SizedBox(height: 20),

                        // Y para la noche
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "Tiempo de riego (noche)",
                            labelStyle: const TextStyle(color: Color(0xFFE3E3E3)),
                            filled: true,
                            fillColor: const Color(0xFF1C1F2A),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none
                            ),
                          ),
                          dropdownColor: const Color(0xFF2B2F3A),
                          style: const TextStyle(color: Color(0xFFE3E3E3)),
                          items: [
                            '15 min',
                            '30 min',
                            '45 min',
                            '60 min',
                          ]
                              .map((e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            // Manejar cambio
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
