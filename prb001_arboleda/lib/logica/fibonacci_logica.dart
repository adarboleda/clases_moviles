class Fibonacci {
  //genera los primeros n terminos: 0, 1, 1, 2, 3, 5, ...
  List<int> generar(int n) {
    List<int> serie = [];
    int a = 0;
    int b = 1;
    for (int i = 0; i < n; i++) {
      serie.add(a);
      int siguiente = a + b;
      a = b;
      b = siguiente;
    }
    return serie;
  }
}
