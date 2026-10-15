import 'package:flutter_test/flutter_test.dart';

import 'package:prb001_arboleda/main.dart';
import 'package:prb001_arboleda/logica/perfecto_logica.dart';
import 'package:prb001_arboleda/logica/fibonacci_logica.dart';
import 'package:prb001_arboleda/logica/armstrong_logica.dart';

void main() {
  test('Números perfectos', () {
    final p = NumeroPerfecto();
    expect(p.esPerfecto(6), true);
    expect(p.esPerfecto(28), true);
    expect(p.esPerfecto(12), false);
    expect(p.esPerfecto(1), false);
  });

  test('Serie de Fibonacci', () {
    expect(Fibonacci().generar(7), [0, 1, 1, 2, 3, 5, 8]);
  });

  test('Número Armstrong', () {
    final a = NumeroArmstrong();
    expect(a.esArmstrong(153), true);
    expect(a.esArmstrong(9474), true);
    expect(a.esArmstrong(5), true);
    expect(a.esArmstrong(10), false);
  });

  testWidgets('El menú muestra los 3 ejercicios', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Ejercicio 4. Números perfectos'), findsOneWidget);
    expect(find.text('Ejercicio 5. Serie de Fibonacci'), findsOneWidget);
    expect(find.text('Ejercicio 6. Número Armstrong'), findsOneWidget);
  });
}
