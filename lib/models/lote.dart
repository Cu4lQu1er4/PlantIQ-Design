import 'aspersor.dart';  // Asegúrate que la ruta sea correcta

class Lote {
  final int id;
  final String nombre;
  final List<Aspersor> aspersores;

  Lote({
    required this.id,
    required this.nombre,
    required this.aspersores,
  });
}
