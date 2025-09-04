class Cultivo {
  final int id;
  final String nombreCultivo;
  final String tipoCultivo;

  Cultivo({
    required this.id,
    required this.nombreCultivo,
    required this.tipoCultivo,
  });

  factory Cultivo.fromJson(Map<String, dynamic> json) => Cultivo(
        id: json['id'],
        nombreCultivo: json['nombre_cultivo'],
        tipoCultivo: json['tipo_cultivo'],
      );
}
