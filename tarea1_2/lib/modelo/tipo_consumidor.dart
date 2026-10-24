// Tipos de consumidor con su cargo fijo y porcentaje de recargo
enum TipoConsumidor {
  residencial(nombre: 'Residencial', cargoFijo: 3.00, porcentajeRecargo: 0.0),
  comercial(nombre: 'Comercial', cargoFijo: 6.00, porcentajeRecargo: 0.10);

  final String nombre;
  final double cargoFijo;
  final double porcentajeRecargo;

  const TipoConsumidor({
    required this.nombre,
    required this.cargoFijo,
    required this.porcentajeRecargo,
  });
}
