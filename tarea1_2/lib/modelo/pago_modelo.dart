import 'consumo_modelo.dart';
import 'tarifa_modelo.dart';

// Resultado del cálculo del valor a pagar
class PagoModelo {
  final ConsumoModelo datos;
  final int consumo;
  final TarifaModelo tarifa;
  final double valorConsumo;
  final double cargoFijo;
  final double subtotal;
  final double porcentajeRecargo;
  final double recargo;
  final double total;

  const PagoModelo({
    required this.datos,
    required this.consumo,
    required this.tarifa,
    required this.valorConsumo,
    required this.cargoFijo,
    required this.subtotal,
    required this.porcentajeRecargo,
    required this.recargo,
    required this.total,
  });
}
