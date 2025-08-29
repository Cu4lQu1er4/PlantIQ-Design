import '../models/lote.dart';
import '../data/mock_data.dart'; // Aquí tienes tus datos de prueba

class ApiService {
  // Método estático que devuelve los lotes
  static Future<List<Lote>> getLotes() async {
    // Simulamos un delay como si viniera de una API real
    await Future.delayed(const Duration(seconds: 1));
    return mockLotes; // mockLotes viene de mock_data.dart
  }
}
