import '../model/numeros_modelos.dart';

class NumerosControladores {
  NumerosModelos calcular(int a, int b, int c) {
    //instancia de la clase NumerosModelos
    NumerosModelos datos = NumerosModelos(a: a, b: b, c: c);
    //NumerosModelos datos = NumerosModelos(a, b, c);

    //contar valores diferentes
    datos.diferentes = {a, b, c}.length;
    //suma y promedio
    datos.suma = a + b + c;
    datos.promedio = datos.suma / 3;
    //encontrar mayor y menor
    int mayor = a;
    int menor = a;
    if (b > mayor) mayor = b;
    if (b < menor) menor = b;
    if (c > mayor) mayor = c;
    if (c < menor) menor = c;

    //producto
    datos.producto = mayor * menor;

    //numeros diferentes
    if (datos.diferentes == 3) {
      int restante = datos.suma - mayor - menor;

      if (restante % 3 == 0) {
        datos.divisible = 'El número $restante es divisible entre 3';
      } else {
        datos.divisible = 'El número $restante no es divisible entre 3';
      }
    }

    return datos;
  }
}
