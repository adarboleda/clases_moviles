import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:py005_operario_mvmm/main.dart';
import 'package:py005_operario_mvmm/view_model/operario_viewmodel.dart';

void main() {
  testWidgets('Calcula el aumento del operario y muestra el resultado', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => OperarioViewModel(),
        child: const MyApp(),
      ),
    );

    await tester.enterText(find.byType(TextField).at(0), '400');
    await tester.enterText(find.byType(TextField).at(1), '12');
    await tester.tap(find.text('Administrativo'));
    await tester.pump();
    await tester.tap(find.text('Calcular'));
    await tester.pumpAndSettle();

    expect(find.text('Administrativo'), findsOneWidget);
    expect(find.text('20 %'), findsOneWidget);
    expect(find.text('\$80.00'), findsOneWidget);
    expect(find.text('\$480.00'), findsOneWidget);
  });
}
