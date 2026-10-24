// Rango de consumo con su tarifa por m³
class TarifaModelo {
  final String nombre;
  final int desde;
  final int? hasta; // null = sin límite superior
  final double precioM3;

  const TarifaModelo({
    required this.nombre,
    required this.desde,
    this.hasta,
    required this.precioM3,
  });

  bool incluye(int consumo) =>
      consumo >= desde && (hasta == null || consumo <= hasta!);

  String get rango =>
      hasta == null ? 'más de ${desde - 1} m³' : '$desde a $hasta m³';
}
