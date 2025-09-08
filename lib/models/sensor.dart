class Sensor {
  final int id;
  final String tipo;
  final double valor;
  final String fechaRegistro;
  final bool activo;

  Sensor({
    required this.id,
    required this.tipo,
    required this.valor,
    required this.fechaRegistro,
    required this.activo,
  });

  factory Sensor.fromJson(Map<String, dynamic> json) => Sensor(
        id: json['id'],
        tipo: json['tipo'],
        valor: (json['valor'] as num).toDouble(),
        fechaRegistro: json['fecha_registro'],
        activo: json['activo'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'tipo': tipo,
        'valor': valor,
        'fecha_registro': fechaRegistro,
        'activo': activo,
      };
}
