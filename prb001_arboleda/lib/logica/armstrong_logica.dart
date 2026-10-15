class NumeroArmstrong {
  //cantidad de cifras del numero
  int cantidadCifras(int numero) {
    return numero.toString().length;
  }

  //suma de cada digito elevado a la cantidad de cifras
  int sumaPotencias(int numero) {
    int cifras = cantidadCifras(numero);
    int suma = 0;
    int temporal = numero;
    while (temporal > 0) {
      int digito = temporal % 10;
      suma = suma + potencia(digito, cifras);
      temporal = temporal ~/ 10;
    }
    return suma;
  }

  //potencia con un ciclo (base elevado a exponente)
  int potencia(int base, int exponente) {
    int resultado = 1;
    for (int i = 0; i < exponente; i++) {
      resultado = resultado * base;
    }
    return resultado;
  }

  //es Armstrong si la suma de potencias es igual al numero
  bool esArmstrong(int numero) {
    return sumaPotencias(numero) == numero;
  }
}
