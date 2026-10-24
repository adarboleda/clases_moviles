import 'tipo_consumidor.dart';

// Datos ingresados en el registro de consumo
class ConsumoModelo {
  final String numeroCuenta;
  final String nombreCliente;
  final int lecturaAnterior;
  final int lecturaActual;
  final TipoConsumidor tipo;

  const ConsumoModelo({
    required this.numeroCuenta,
    required this.nombreCliente,
    required this.lecturaAnterior,
    required this.lecturaActual,
    required this.tipo,
  });
}
