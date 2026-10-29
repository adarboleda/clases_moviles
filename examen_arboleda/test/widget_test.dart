import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:examen_arboleda/main.dart';
import 'package:examen_arboleda/view_model/consumo_viewmodel.dart';

void main() {
  test('Calcula el exceso de minutos y gigas', () {
    final vm = ConsumoViewModel();
    vm.actualizarMinutos('350');
    vm.actualizarGigas('12.5');
    final r = vm.calcular();

    expect(r.minutosExceso, 50);
    expect(r.costoMinutos, closeTo(2.50, 0.001));
    expect(r.gigasExceso, closeTo(2.5, 0.001));
    expect(r.costoGigas, closeTo(5.00, 0.001));
    expect(r.totalAdicional, closeTo(7.50, 0.001));
  });

  test('Sin exceso no hay valor adicional', () {
    final vm = ConsumoViewModel();
    vm.actualizarMinutos('300');
    vm.actualizarGigas('10');
    expect(vm.calcular().totalAdicional, 0);
  });

  testWidgets('Navega de inicio a resultado con el valor adicional', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => ConsumoViewModel(),
        child: const MyApp(),
      ),
    );

    await tester.ensureVisible(find.text('Comenzar'));
    await tester.tap(find.text('Comenzar'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), '400');
    await tester.enterText(find.byType(TextField).at(1), '11');
    await tester.pump();
    await tester.ensureVisible(find.text('Calcular'));
    await tester.tap(find.text('Calcular'));
    await tester.pumpAndSettle();

    //100 min * 0.05 = 5.00 ; 1 GB * 2 = 2.00 ; total 7.00
    expect(find.text('\$7.00'), findsOneWidget);
    expect(find.text('\$5.00'), findsOneWidget);
    expect(find.text('\$2.00'), findsOneWidget);
  });
}
