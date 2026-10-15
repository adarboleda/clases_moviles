class Calculadora {
  double sumar(double a, double b) {
    return a + b;
  }

  double restar(double a, double b) {
    return a - b;
  }

  double multiplicar(double a, double b) {
    return a * b;
  }

  double dividir(double a, double b) {
    if (b == 0) {
      throw ArgumentError('No se puede dividir entre cero');
    }
    return a / b;
  }
}
