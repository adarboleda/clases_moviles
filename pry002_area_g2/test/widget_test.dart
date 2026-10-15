import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pry002_area_g2/pantallas/area_terreno.dart';

void main() {
  testWidgets('calcula area, perimetro y valor del terreno', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: AreaPantalla()),
    );

    final campos = find.byType(TextField);
    await tester.enterText(campos.at(0), '10');
    await tester.enterText(campos.at(1), '5');
    await tester.tap(find.text('Calcular'));
    await tester.pump();

    expect(find.text('Area: 50.00 m2'), findsOneWidget);
    expect(find.text('Perimetro: 30.00 m'), findsOneWidget);
    expect(find.text('Valor: 7500.00'), findsOneWidget);
  });
}
