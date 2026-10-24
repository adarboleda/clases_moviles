// Formato de valores monetarios para mostrar en pantalla
String formatoMoneda(double valor) => '\$${valor.toStringAsFixed(2)}';

String formatoPorcentaje(double valor) => '${(valor * 100).round()}%';
