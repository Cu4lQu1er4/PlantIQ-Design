import '../models/riegos.dart';

class Cultivo {
  final int id;
  final String nombreCultivo;
  final String tipoCultivo;
  final List<Riego> programaciones;

  Cultivo({
    required this.id,
    required this.nombreCultivo,
    required this.tipoCultivo,
    List<Riego>? programaciones,
  }) : programaciones = programaciones ?? [];

  factory Cultivo.fromJson(Map<String, dynamic> json) {
    return Cultivo(
      id: json['id'] as int,
      nombreCultivo: json['nombre_cultivo'] as String,
      tipoCultivo: json['tipo_cultivo'] as String,
      programaciones: (json['programaciones'] as List<dynamic>?)
              ?.map((r) => Riego.fromJson(r as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
