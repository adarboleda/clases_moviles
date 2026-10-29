import 'package:flutter/material.dart';

import '../model/operario_model.dart';

class OperarioViewModel extends ChangeNotifier {
  String tipoOperario = 'Operativo';

  void seleccionarTipo(String tipo) {
    tipoOperario = tipo;
    notifyListeners();
  }

  OperarioModel calcular(double sueldo, int antiguedad) {
    double porcentaje = 0.0;

    if (sueldo < 500 && antiguedad >= 10) {
      porcentaje = 0.20;
    } else if (sueldo < 500 && antiguedad < 10) {
      porcentaje = 0.05;
    }

    double aumento = sueldo * porcentaje;
    double sueldoFinal = sueldo + aumento;

    return OperarioModel(
      sueldo: sueldo,
      antiguedad: antiguedad,
      tipo: tipoOperario,
      porcentaje: porcentaje,
      aumento: aumento,
      sueldoFinal: sueldoFinal,
    );
  }
}
