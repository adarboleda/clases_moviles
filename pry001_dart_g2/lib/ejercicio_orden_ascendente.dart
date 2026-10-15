import 'dart:io';

void main() {
  stdout.write('Ingrese el primer numero: ');
  int n1 = int.parse(stdin.readLineSync()!);
  stdout.write('Ingrese el segundo numero: ');
  int n2 = int.parse(stdin.readLineSync()!);
  stdout.write('Ingrese el tercer numero: ');
  int n3 = int.parse(stdin.readLineSync()!);

  //proceso
  if (n1 > n2 && n2 > n3) {
    print('Los numero esta en orden ascendente)');
  } else {
    print('Los numero no esta en orden ascendente)');
  }
}
