import 'package:flutter/material.dart';

import '../modelo/edad_modelo.dart';

class EdadControlador {
  //metodo calcular edad

  EdadModelo calcularEdad(int dia, int mes, int anio) {
    DateTime hoy = DateTime.now();
    DateTime nacimiento = DateTime(anio, mes, dia);

    int anios = hoy.year - nacimiento.year;
    int meses = hoy.month - nacimiento.month;
    int dias = hoy.day - nacimiento.day;

    if (dias < 0) {
      meses--;
      int diasMesesAnteriores = DateTime(hoy.year, hoy.month, 0).day;
      dias += diasMesesAnteriores;
    }

    if (meses < 0) {
      anios--;
      meses += 12;
    }

    return EdadModelo(anios: anios, meses: meses, dias: dias);
  }
}
