import 'package:flutter/material.dart';

import '../model/consumo_model.dart';

class ConsumoViewModel extends ChangeNotifier {
  int minutos = 0;
  double gigas = 0;
  String? errorMinutos;
  String? errorGigas;

  //se llama cada vez que el usuario escribe para actualizar la vista
  void actualizarMinutos(String texto) {
    final valor = int.tryParse(texto.trim());
    if (texto.trim().isEmpty) {
      minutos = 0;
      errorMinutos = null;
    } else if (valor == null || valor < 0) {
      minutos = 0;
      errorMinutos = 'Ingrese un número entero válido';
    } else {
      minutos = valor;
      errorMinutos = null;
    }
    notifyListeners();
  }

  void actualizarGigas(String texto) {
    final valor = double.tryParse(texto.trim().replaceAll(',', '.'));
    if (texto.trim().isEmpty) {
      gigas = 0;
      errorGigas = null;
    } else if (valor == null || valor < 0) {
      gigas = 0;
      errorGigas = 'Ingrese un número válido';
    } else {
      gigas = valor;
      errorGigas = null;
    }
    notifyListeners();
  }

  bool get esValido => errorMinutos == null && errorGigas == null;

  //porcentaje de uso del plan para las barras de progreso (0 a 1)
  double get usoMinutos => (minutos / ConsumoModel.minutosPlan).clamp(0.0, 1.0);
  double get usoGigas => (gigas / ConsumoModel.gigasPlan).clamp(0.0, 1.0);

  bool get excedeMinutos => minutos > ConsumoModel.minutosPlan;
  bool get excedeGigas => gigas > ConsumoModel.gigasPlan;

  ConsumoModel calcular() {
    int minutosExceso = 0;
    double gigasExceso = 0;

    if (minutos > ConsumoModel.minutosPlan) {
      minutosExceso = minutos - ConsumoModel.minutosPlan;
    }
    if (gigas > ConsumoModel.gigasPlan) {
      gigasExceso = gigas - ConsumoModel.gigasPlan;
    }

    double costoMinutos = minutosExceso * ConsumoModel.costoMinutoExtra;
    double costoGigas = gigasExceso * ConsumoModel.costoGigaExtra;

    return ConsumoModel(
      minutos: minutos,
      gigas: gigas,
      minutosExceso: minutosExceso,
      gigasExceso: gigasExceso,
      costoMinutos: costoMinutos,
      costoGigas: costoGigas,
      totalAdicional: costoMinutos + costoGigas,
    );
  }

  void limpiar() {
    minutos = 0;
    gigas = 0;
    errorMinutos = null;
    errorGigas = null;
    notifyListeners();
  }
}
