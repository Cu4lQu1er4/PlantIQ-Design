import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/sensor.dart';
import '../models/programacion_riego.dart';
import '../models/registro_riego.dart';
import '../models/lectura_sensor.dart';
import '../models/cultivo.dart';
import '../models/lote.dart';
import '../models/user_detail.dart';

class ApiService {
  static const String baseUrl = 'http://<tu-ip-local>:8000/api';

  // Obtiene headers con token JWT
  static Future<Map<String, String>> getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  // Registro de usuario
  static Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String password2,
  }) async {
    final url = Uri.parse('$baseUrl/register/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'password2': password2,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Error en el registro: ${response.body}');
    }
  }

  // Login (obtención de tokens)
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error en login: ${response.body}');
    }
  }

  // Validar token de acceso
  static Future<bool> validateAccess() async {
    final headers = await getHeaders();
    final url = Uri.parse('$baseUrl/acceso-validate/');
    final response = await http.get(url, headers: headers);
    return response.statusCode == 200;
  }

  // Obtener detalle usuario actual
  static Future<UserDetail> getUserDetail() async {
    final headers = await getHeaders();
    final url = Uri.parse('$baseUrl/usuario-actual/');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return UserDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener detalle de usuario');
    }
  }

  // ACTIVAR cuenta con token desde email (GET)
  static Future<void> activateAccount(String token) async {
    final url = Uri.parse('$baseUrl/activar-cuenta/$token/');
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception('Error al activar cuenta');
    }
  }

  // --- Sensores ---
  static Future<List<Sensor>> getSensores() async {
    final headers = await getHeaders();
    final url = Uri.parse('$baseUrl/sensores/');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((j) => Sensor.fromJson(j)).toList();
    } else {
      throw Exception('Error al obtener sensores');
    }
  }

  static Future<void> toggleSensor(int id) async {
    final headers = await getHeaders();
    final url = Uri.parse('$baseUrl/sensores/$id/toggle/');
    final response = await http.post(url, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Error al alternar sensor');
    }
  }

  static Future<void> activarSensor(int id) async {
    final headers = await getHeaders();
    final url = Uri.parse('$baseUrl/sensores/$id/activar/');
    final response = await http.post(url, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Error al activar sensor');
    }
  }

  static Future<void> desactivarSensor(int id) async {
    final headers = await getHeaders();
    final url = Uri.parse('$baseUrl/sensores/$id/desactivar/');
    final response = await http.post(url, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Error al desactivar sensor');
    }
  }

  // --- Programación riego ---
  static Future<List<ProgramacionRiego>> getProgramacionesRiego() async {
    final headers = await getHeaders();
    final url = Uri.parse('$baseUrl/programacion_riego/');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((j) => ProgramacionRiego.fromJson(j)).toList();
    } else {
      throw Exception('Error al obtener programaciones de riego');
    }
  }

  static Future<List<ProgramacionRiego>> getProgramacionesRiegoAdmin() async {
    final headers = await getHeaders();
    final url = Uri.parse('$baseUrl/programacion_riego_admin/');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((j) => ProgramacionRiego.fromJson(j)).toList();
    } else {
      throw Exception('Error al obtener programaciones de riego admin');
    }
  }

  static Future<void> crearProgramacionRiego({
    required String inicio,
    required int duracion,
    required bool activo,
    int? numeroLotes,
  }) async {
    final headers = await getHeaders();
    final url = Uri.parse('$baseUrl/programacion_riego_admin/');
    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'inicio': inicio,
        'duracion': duracion,
        'activo': activo,
        'numero_lotes': numeroLotes,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear programación de riego');
    }
  }

  static Future<void> editarProgramacionRiego({
    required int id,
    required String inicio,
    required int duracion,
    required bool activo,
    int? numeroLotes,
  }) async {
    final headers = await getHeaders();
    final url = Uri.parse('$baseUrl/programacion_riego_admin/$id/');
    final response = await http.put(
      url,
      headers: headers,
      body: json.encode({
        'inicio': inicio,
        'duracion': duracion,
        'activo': activo,
        'numero_lotes': numeroLotes,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al editar programación de riego');
    }
  }

  static Future<void> eliminarProgramacionRiego(int id) async {
    final headers = await getHeaders();
    final url = Uri.parse('$baseUrl/programacion_riego_admin/$id/');
    final response = await http.delete(url, headers: headers);
    if (response.statusCode != 204) {
      throw Exception('Error al eliminar programación de riego');
    }
  }

  static Future<void> activarRiego(int id) async {
    final headers = await getHeaders();
    final url = Uri.parse('$baseUrl/programacion_riego/$id/activar_riego/');
    final response = await http.post(url, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Error al activar riego');
    }
  }

  // --- Registro Riego ---
  static Future<List<RegistroRiego>> getRegistrosRiego() async {
    final headers = await getHeaders();
    final url = Uri.parse('$baseUrl/registro_riego/');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((j) => RegistroRiego.fromJson(j)).toList();
    } else {
      throw Exception('Error al obtener registros de riego');
    }
  }

  static Future<void> crearRegistroRiego({
    required int sensorId,
    required int duracionMinutos,
  }) async {
    final headers = await getHeaders();
    final url = Uri.parse('$baseUrl/registro_riego/');
    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'sensor': sensorId,
        'duracion_minutos': duracionMinutos,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear registro de riego');
    }
  }

  // --- Lecturas de humedad ---
  static Future<List<LecturaSensor>> getLecturasHumedad() async {
    final headers = await getHeaders();
    final url = Uri.parse('$baseUrl/lecturas_humedad/');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((j) => LecturaSensor.fromJson(j)).toList();
    } else {
      throw Exception('Error al obtener lecturas de humedad');
    }
  }

  static Future<Map<String, dynamic>> getEstadisticasHumedadSemanal() async {
    final headers = await getHeaders();
    final url = Uri.parse('$baseUrl/estadisticas_humedad_semanal/');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener estadísticas de humedad');
    }
  }

  // --- Cultivos ---
  static Future<List<Cultivo>> getCultivos() async {
    final headers = await getHeaders();
    final url = Uri.parse('$baseUrl/cultivos/');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((j) => Cultivo.fromJson(j)).toList();
    } else {
      throw Exception('Error al obtener cultivos');
    }
  }
}
