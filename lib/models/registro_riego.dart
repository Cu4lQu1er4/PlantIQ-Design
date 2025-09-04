class RegistroRiego {
  final int id;
  final String sensor; // Es string en serializer
  final String usuario; // Es string en serializer
  final String inicio;
  final int duracionMinutos;
  final bool activo;

  RegistroRiego({
    required this.id,
    required this.sensor,
    required this.usuario,
    required this.inicio,
    required this.duracionMinutos,
    required this.activo,
  });

  factory RegistroRiego.fromJson(Map<String, dynamic> json) => RegistroRiego(
        id: json['id'],
        sensor: json['sensor'],
        usuario: json['usuario'],
        inicio: json['inicio'],
        duracionMinutos: json['duracion_minutos'],
        activo: json['activo'],
      );
}
