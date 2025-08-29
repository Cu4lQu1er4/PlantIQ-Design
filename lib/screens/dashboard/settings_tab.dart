import 'package:flutter/material.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool modoClaro = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F2A),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Ajustes",
              style: const TextStyle(
                fontSize: 25,
                color: Color(0xFFE3E3E3),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.light_mode, color: Color(0xFFE3E3E3)),
            title: const Text('Modo claro', style: TextStyle(color: Color(0xFFE3E3E3))),
            trailing: Switch(
              value: modoClaro,
              onChanged: (value) {
                setState(() {
                  modoClaro = value;
                });
                // Aquí puedes agregar lógica para cambiar el tema global de la app
              },
            ),
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.person, color: Color(0xFFE3E3E3)),
            title: const Text('Datos del Usuario', style: TextStyle(color: Color(0xFFE3E3E3))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditarDatosUsuario()),
              );
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.agriculture, color: Color(0xFFE3E3E3)),
            title: const Text('Datos de la Finca', style: TextStyle(color: Color(0xFFE3E3E3))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditarDatosFinca()),
              );
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.lock, color: Color(0xFFE3E3E3)),
            title: const Text('Autenticación', style: TextStyle(color: Color(0xFFE3E3E3))),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color(0xFF2B2F3A),
                  title: const Text('Opciones de Autenticación', style: TextStyle(color: Color(0xFFE3E3E3))),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Navegación o formulario para cambiar contraseña
                        },
                        child: const Text('Cambiar Contraseña'),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Lógica para cerrar sesión
                        },
                        child: const Text('Cerrar Sesión'),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar', style: TextStyle(color: Color(0xFFE3E3E3))),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class EditarDatosUsuario extends StatefulWidget {
  const EditarDatosUsuario({super.key});

  @override
  State<EditarDatosUsuario> createState() => _EditarDatosUsuarioState();
}

class _EditarDatosUsuarioState extends State<EditarDatosUsuario> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nombresController =
      TextEditingController(text: "Daniel Samir");
  final TextEditingController apellidosController =
      TextEditingController(text: "Gonzáles Pérez");
  final TextEditingController telefonoController =
      TextEditingController(text: "0180004455");
  final TextEditingController correoController =
      TextEditingController(text: "GonzalesPerezSamir@gmail.com");
  final TextEditingController rolController =
      TextEditingController(text: "Administrador");
  final TextEditingController direccionController =
      TextEditingController(text: "Calle 22 sur # 56-27 n");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B2F3A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFE3E3E3)),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: '',
        ),
        title: const Text(
          'Editar Datos del usuario',
          style: TextStyle(color: Color(0xFFE3E3E3)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(nombresController, 'Nombres', icon: Icons.person),
              const SizedBox(height: 12),
              _buildTextField(apellidosController, 'Apellidos', icon: Icons.person_outline),
              const SizedBox(height: 12),
              _buildTextField(telefonoController, 'Teléfono de contacto',
                  icon: Icons.phone, keyboardType: TextInputType.phone),
              const SizedBox(height: 12),
              _buildTextField(correoController, 'Correo Electrónico',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  isEmail: true),
              const SizedBox(height: 12),
              _buildTextField(rolController, 'Rol', icon: Icons.badge),
              const SizedBox(height: 12),
              _buildTextField(direccionController, 'Dirección', icon: Icons.home),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Datos guardados correctamente')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2B2F3A),
                ),
                child: const Text('Guardar',
                    style: TextStyle(
                      color: Color(0xFFE3E3E3),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {IconData? icon,
      String? hintText,
      TextInputType keyboardType = TextInputType.text,
      bool isEmail = false}) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Color(0xFFE3E3E3)),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: const TextStyle(color: Color(0xFFE3E3E3)),
        filled: true,
        fillColor: const Color(0xFF2B2F3A),
        prefixIcon:
            icon != null ? Icon(icon, color: const Color(0xFFE3E3E3)) : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none, // Sin borde visible
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none, // Sin borde visible al enfocar
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa $label'.toLowerCase();
        }
        if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Por favor ingresa un correo válido';
        }
        return null;
      },
    );
  }
}

class EditarDatosFinca extends StatefulWidget {
  const EditarDatosFinca({super.key});

  @override
  State<EditarDatosFinca> createState() => _EditarDatosFincaState();
}

class _EditarDatosFincaState extends State<EditarDatosFinca> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nombreFincaController =
      TextEditingController(text: "Finca Napolitana");
  final TextEditingController tipoCultivoController =
      TextEditingController(text: "Granos, tubérculos y frutas");
  final TextEditingController tamanoAreaController = TextEditingController();
  final TextEditingController zonasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B2F3A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFE3E3E3)),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: '',
        ),
        title: const Text(
          'Editar Datos de la Finca',
          style: TextStyle(color: Color(0xFFE3E3E3)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(nombreFincaController, 'Nombre de la finca o predio',
                  icon: Icons.landscape),
              const SizedBox(height: 12),
              _buildTextField(tipoCultivoController, 'Tipo de cultivo(s) registrados',
                  icon: Icons.eco),
              const SizedBox(height: 12),
              _buildTextField(tamanoAreaController,
                  'Tamaño del área cubierta por aspersores (m² o ha)',
                  icon: Icons.crop_square),
              const SizedBox(height: 12),
              _buildTextField(zonasController, 'Zonas configuradas',
                  icon: Icons.map, hintText: 'Ej. Lote 1, Lote 2...'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Datos de la finca guardados')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2B2F3A),
                ),
                child: const Text('Guardar',
                    style: TextStyle(
                      color: Color(0xFFE3E3E3),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {IconData? icon, String? hintText}) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Color(0xFFE3E3E3)),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: const TextStyle(color: Color(0xFFE3E3E3)),
        filled: true,
        fillColor: const Color(0xFF2B2F3A),
        prefixIcon:
            icon != null ? Icon(icon, color: const Color(0xFFE3E3E3)) : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none, // Sin borde visible
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none, // Sin borde visible al enfocar
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa $label'.toLowerCase();
        }
        return null;
      },
    );
  }
}
