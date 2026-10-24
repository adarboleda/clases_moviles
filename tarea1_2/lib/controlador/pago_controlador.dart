import '../modelo/consumo_modelo.dart';
import '../modelo/pago_modelo.dart';
import '../modelo/tarifa_modelo.dart';
import '../modelo/tipo_consumidor.dart';

class PagoControlador {
  // Rangos de consumo definidos para la práctica
  static const List<TarifaModelo> tarifas = [
    TarifaModelo(nombre: 'Básica', desde: 0, hasta: 15, precioM3: 0.45),
    TarifaModelo(nombre: 'Intermedia', desde: 16, hasta: 30, precioM3: 0.70),
    TarifaModelo(nombre: 'Superior', desde: 31, precioM3: 1.05),
  ];

  //validaciones de entrada

  String? validarCuenta(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Ingrese el número de cuenta';
    if (!RegExp(r'^\d{6,10}$').hasMatch(texto)) {
      return 'La cuenta debe tener entre 6 y 10 dígitos';
    }
    return null;
  }

  String? validarNombre(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Ingrese el nombre del cliente';
    if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]+$').hasMatch(texto)) {
      return 'Solo se permiten letras y espacios';
    }
    if (texto.length < 3) return 'El nombre es demasiado corto';
    return null;
  }

  String? validarLecturaAnterior(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Ingrese la lectura anterior';
    if (int.tryParse(texto) == null) return 'Ingrese un número entero';
    return null;
  }

  String? validarLecturaActual(String? valor, String lecturaAnterior) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Ingrese la lectura actual';
    final actual = int.tryParse(texto);
    if (actual == null) return 'Ingrese un número entero';
    final anterior = int.tryParse(lecturaAnterior.trim());
    if (anterior != null && actual < anterior) {
      return 'Debe ser mayor o igual a la anterior';
    }
    return null;
  }

  String? validarTipo(TipoConsumidor? valor) {
    if (valor == null) return 'Seleccione el tipo de consumidor';
    return null;
  }

  //metodo obtener tarifa segun el rango de consumo
  TarifaModelo obtenerTarifa(int consumo) {
    return tarifas.firstWhere((tarifa) => tarifa.incluye(consumo));
  }

  //metodo calcular pago
  PagoModelo calcularPago(ConsumoModelo datos) {
    int consumo = datos.lecturaActual - datos.lecturaAnterior;
    TarifaModelo tarifa = obtenerTarifa(consumo);

    double valorConsumo = _redondear(consumo * tarifa.precioM3);
    double cargoFijo = datos.tipo.cargoFijo;
    double subtotal = _redondear(valorConsumo + cargoFijo);
    double recargo = _redondear(subtotal * datos.tipo.porcentajeRecargo);
    double total = _redondear(subtotal + recargo);

    return PagoModelo(
      datos: datos,
      consumo: consumo,
      tarifa: tarifa,
      valorConsumo: valorConsumo,
      cargoFijo: cargoFijo,
      subtotal: subtotal,
      porcentajeRecargo: datos.tipo.porcentajeRecargo,
      recargo: recargo,
      total: total,
    );
  }

  double _redondear(double valor) => (valor * 100).round() / 100;
}
