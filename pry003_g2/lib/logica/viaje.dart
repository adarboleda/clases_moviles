class Viaje {
  //metodo
  double calcularCostoAlumno(int alumnos) {
    double costo;

    if (alumnos >= 100) {
      costo = 65;
    } else if (alumnos >= 50) {
      costo = 70;
    } else if (alumnos >= 30) {
      costo = 95;
    } else {
      costo = 4000 / alumnos;
    }
    return costo;
  }

  //metodo pago total
  double calcularPagoTotal(int alumnos) {
    double total;
    if (alumnos < 30) {
      total = 4000;
    } else {
      total = alumnos * calcularCostoAlumno(alumnos);
    }
    return total;
  }
}
