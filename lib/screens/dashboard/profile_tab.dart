import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Columna principal (izquierda)
          Expanded(
            flex: 3,
            child: Column(
              children: [
                // Información de la finca
                Expanded(
                  flex: 1, // mismo tamaño que la sección de mapa
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B2F3A),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(Icons.maps_home_work_sharp, color: Color(0xFFE3E3E3), size: 50),
                          SizedBox(height: 20),
                          Text(
                            'Nombre de la finca o predio:',
                            style: TextStyle(
                                color: Color(0xFFE3E3E3),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Tipo de cultivo(s) registrados: Granos,',
                            style: TextStyle(
                                color: Color(0xFFE3E3E3),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Tamaño del área cubierta por aspersores:',
                            style: TextStyle(
                                color: Color(0xFFE3E3E3),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Zonas configuradas:',
                            style: TextStyle(
                                color: Color(0xFFE3E3E3),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Texto adicional para probar el scroll...',
                            style: TextStyle(
                                color: Color(0xFFE3E3E3),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Más texto de ejemplo...',
                            style: TextStyle(
                                color: Color(0xFFE3E3E3),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Sección de mapa
                Expanded(
                  flex: 1, // mismo tamaño que la sección de información
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B2F3A),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ubicación de la finca o predio',
                          style: TextStyle(
                              color: Color(0xFFE3E3E3),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  '', // Aquí va la URL de tu mapa o imagen
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

          const SizedBox(width: 20),

          // Columna lateral (derecha)
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: const Color(0xFF2B2F3A),
                borderRadius: BorderRadius.circular(15),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Avatar
                    const CircleAvatar(
                      radius: 120,
                      backgroundColor: Color(0xFFE3E3E3),
                      child: Icon(Icons.person, size: 150, color: Colors.black),
                    ),
                    const SizedBox(height: 70),
                    const Text('Nombres', style: TextStyle(color: Color(0xFFE3E3E3), fontSize: 15)),
                    const Text('Daniel Samir', style: TextStyle(color: Color(0xFFE3E3E3), fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Text('Apellidos', style: TextStyle(color: Color(0xFFE3E3E3), fontSize: 15)),
                    const Text('Gonzáles Pérez', style: TextStyle(color: Color(0xFFE3E3E3), fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Text('Teléfono de contacto', style: TextStyle(color: Color(0xFFE3E3E3), fontSize: 15)),
                    const Text('0180004455', style: TextStyle(color: Color(0xFFE3E3E3), fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Text('Correo Electrónico', style: TextStyle(color: Color(0xFFE3E3E3), fontSize: 15)),
                    Text(
                      'GonzalesPerezSamir@gmail.com',
                      style: const TextStyle(color: Color(0xFFE3E3E3), fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text('Rol', style: TextStyle(color: Color(0xFFE3E3E3), fontSize: 15)),
                    const Text('Administrador', style: TextStyle(color: Color(0xFFE3E3E3), fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Text('Dirección', style: TextStyle(color: Color(0xFFE3E3E3), fontSize: 15)),
                    const Text('Calle 22 sur # 56-27', style: TextStyle(color: Color(0xFFE3E3E3), fontSize: 15, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
