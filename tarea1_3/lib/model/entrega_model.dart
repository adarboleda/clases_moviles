import 'package:flutter/material.dart';

//forma de entrega del pedido con su costo adicional
enum EntregaModel {
  local('Comer en el local', Icons.storefront, 0.0),
  llevar('Para llevar', Icons.takeout_dining, 0.50),
  domicilio('A domicilio', Icons.delivery_dining, 2.00);

  final String nombre;
  final IconData icono;
  final double costo;

  const EntregaModel(this.nombre, this.icono, this.costo);
}
