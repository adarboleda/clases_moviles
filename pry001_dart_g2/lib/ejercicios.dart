//Ejercicio 1: crear un mensaje
/*void main() {
  print('Hola mundo cruel.....!');
}*/

//Ejercicio 2: varaibles y tipos de datos
/*void main() {
  String nombre = 'Juan';
  int edad = 23;
  double promedio = 13.99;
  bool aprobado = false;

  print('Nombre: $nombre');
  print('Edad: $edad');
  print('Promedio: $promedio');
  print('Aprobado: $aprobado');
}*/

//Ejercicio 3: Operadores aritméticos
/*void main() {
  int a = 10;
  int b = 5;

  print('Suma: ${a + b}');
  print('Resta: ${a - b}');
  print('Multiplicación: ${a * b}');
  print('División: ${a / b}');
  print('Potencia: ${a ~/ b}');
  print('Módulo: ${a % b}');
}*/

//Ejercicio 4: if y operadores %
/*void main() {
  int numero = 7;

  if (numero % 2 == 0) {
    print('$numero es un número par');
  } else {
    print('$numero es un número impar');
  }
}*/

//Ejercicio 5: controladores %
/*void main() {
  for (int i = 1; i <= 10; i++) {
    print('Número: $i');
  }
}*/

//Ejercicio 6: mostrar los divisores de un numero y la suma
void main() {
  int numero = 6;
  int sumaDivisores = 0;

  print('Divisores de $numero:');
  for (int i = 1; i <= numero; i++) {
    if (numero % i == 0) {
      print(i);
      sumaDivisores += i;
    }
  }

  print('Suma de los divisores: $sumaDivisores');
}
