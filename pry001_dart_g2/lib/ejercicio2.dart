import 'dart:io';

void main() {
  //datos
  double precioKilo = 72.70;
  stdout.write('Ingrese los kilos comprados: ');
  double kilos = double.parse(stdin.readLineSync()!);

  //proceso
  int porcentaje;
  String descripcion;

  if (kilos <= 2) {
    porcentaje = 0;
    descripcion = 'De 0 a 2 kilos: sin descuento';
  } else if (kilos <= 5) {
    porcentaje = 10;
    descripcion = 'De 2.01 a 5 kilos: 10% de descuento';
  } else if (kilos <= 10) {
    porcentaje = 15;
    descripcion = 'De 5.01 a 10 kilos: 15% de descuento';
  } else {
    porcentaje = 20;
    descripcion = 'De 10.01 kilos o mas: 20% de descuento';
  }

  double subtotal = precioKilo * kilos;
  double montoDescuento = subtotal * porcentaje / 100;
  double total = subtotal - montoDescuento;

  //salida
  print('Precio por kilo: $precioKilo');
  print('Kilos comprados: $kilos');
  print('Subtotal: ${subtotal.toStringAsFixed(2)}');
  print('Descuento aplicado: $porcentaje%');
  print('Monto descuento: ${montoDescuento.toStringAsFixed(2)}');
  print('Total a pagar: ${total.toStringAsFixed(2)}');
  print('Descripcion del descuento: $descripcion');
}
