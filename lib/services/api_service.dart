import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/programacion_riego.dart';
import '../models/lote.dart'; // Asegúrate de importar tu modelo Lote

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  // Headers con token JWT
  static Future<Map<String, String>> getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  // 🔄 Obtener lista de programaciones de riego (Admin)
  static Future<List<ProgramacionRiego>> getProgramacionesRiego() async {
    final headers = await getHeaders();
    final url = Uri.parse('$baseUrl/programacion_riego_admin/');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ProgramacionRiego.fromJson(json)).toList();
    } else {
      throw Exception(
        'Error al obtener programaciones: ${response.statusCode}',
      );
    }
  }

  // Nuevo: 🔄 Obtener lista de lotes
  static Future<List<Lote>> getLotes() async {
    final headers = await getHeaders();
    final url = Uri.parse(
      '$baseUrl/cultivos/',
    ); // Cambia el endpoint si es distinto
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Lote.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener lotes: ${response.statusCode}');
    }
  }

  // ➕ Crear nueva programación de riego
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
      throw Exception('Error al crear riego: ${response.statusCode}');
    }
  }

  // ✏️ Editar programación de riego
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
      throw Exception('Error al editar riego: ${response.statusCode}');
    }
  }

  // ❌ Eliminar programación de riego
  static Future<void> eliminarProgramacionRiego(int id) async {
    final headers = await getHeaders();
    final url = Uri.parse('$baseUrl/programacion_riego_admin/$id/');
    final response = await http.delete(url, headers: headers);

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar riego: ${response.statusCode}');
    }
  }
}
