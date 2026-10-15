class NumeroPerfecto {
  //suma de los divisores propios (menores que el numero)
  int sumaDivisores(int numero) {
    int suma = 0;
    for (int i = 1; i < numero; i++) {
      if (numero % i == 0) {
        suma = suma + i;
      }
    }
    return suma;
  }

  //lista de divisores propios para mostrarlos en pantalla
  List<int> divisores(int numero) {
    List<int> lista = [];
    for (int i = 1; i < numero; i++) {
      if (numero % i == 0) {
        lista.add(i);
      }
    }
    return lista;
  }

  //es perfecto si la suma de sus divisores es igual al numero
  bool esPerfecto(int numero) {
    if (numero <= 1) {
      return false;
    }
    return sumaDivisores(numero) == numero;
  }
}
