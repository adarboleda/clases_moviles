import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:tarea2_2_biblioteca/main.dart';

import 'fakes.dart';

Future<RepositorioFalso> abrirApp(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(420, 900));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  final repo = RepositorioFalso();
  await tester.pumpWidget(
    MultiProvider(
      providers: crearProveedores(
        libros: repo,
        estudiantes: repo,
        prestamos: repo,
        reloj: () => hoy,
      ),
      child: const MiApp(),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}

void main() {
  testWidgets('registra un préstamo desde el detalle del libro', (
    tester,
  ) async {
    final repo = await abrirApp(tester);

    //solo aparecen los libros con stock en el carrusel
    expect(find.text('Libros disponibles'), findsOneWidget);
    expect(find.text('Clean Code'), findsWidgets);
    expect(find.text('Rayuela'), findsNothing);

    await tester.tap(find.text('Autor 1'));
    await tester.pumpAndSettle();
    expect(find.text('Detalle del libro'), findsOneWidget);
    expect(find.text('2 de 2'), findsOneWidget);

    await tester.tap(find.text('Solicitar préstamo'));
    await tester.pumpAndSettle();
    expect(find.text('Nuevo préstamo'), findsOneWidget);

    //Ana ya tiene 3 prestamos activos
    await tester.tap(find.byType(DropdownButtonFormField<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ana Torres · 1726354890').last);
    await tester.pumpAndSettle();
    expect(find.textContaining('3 préstamos activos'), findsOneWidget);

    await tester.tap(find.text('Registrar préstamo'));
    await tester.pumpAndSettle();
    expect(find.text('Nuevo préstamo'), findsOneWidget);
    expect(repo.registrados, 0);

    //Carlos si puede pedir el libro
    await tester.tap(find.text('Ana Torres · 1726354890'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Carlos Ruiz · 1755512345').last);
    await tester.pumpAndSettle();
    expect(find.textContaining('Puede solicitar el préstamo'), findsOneWidget);

    await tester.tap(find.text('Registrar préstamo'));
    await tester.pumpAndSettle();

    expect(repo.registrados, 1);
    expect(find.text('Detalle del libro'), findsOneWidget);
    expect(find.text('1 de 2'), findsOneWidget);
    expect(find.textContaining('Préstamo registrado'), findsOneWidget);
  });

  testWidgets('registra la devolución de un préstamo vencido', (tester) async {
    await abrirApp(tester);

    await tester.tap(find.text('Préstamos').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Vencidos (1)'));
    await tester.pumpAndSettle();
    expect(find.text('Luis Pérez'), findsOneWidget);

    await tester.tap(find.text('Luis Pérez'));
    await tester.pumpAndSettle();
    expect(find.text('Días de retraso'), findsOneWidget);

    await tester.tap(find.text('Registrar devolución'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Confirmar'));
    await tester.pumpAndSettle();

    expect(find.text('Devolución registrada'), findsOneWidget);
    expect(
      find.textContaining('no puede volver a estado activo'),
      findsOneWidget,
    );
    expect(find.text('Registrar devolución'), findsNothing);
  });

  testWidgets('registra un estudiante con validaciones', (tester) async {
    await abrirApp(tester);

    await tester.tap(find.text('Estudiantes').last);
    await tester.pumpAndSettle();
    expect(find.text('3 registrados'), findsOneWidget);

    await tester.tap(find.text('Registrar'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.check));
    await tester.pumpAndSettle();
    expect(find.text('Ingrese la cédula'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Cédula'),
      '1700000001',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nombre completo'),
      'Pedro Vega',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Correo institucional'),
      'pedro@uni.edu.ec',
    );
    await tester.tap(find.text('Carrera'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Electrónica').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.check));
    await tester.pumpAndSettle();

    expect(find.text('Estudiante registrado'), findsOneWidget);
    expect(find.text('4 registrados'), findsOneWidget);
    expect(find.text('Pedro Vega'), findsOneWidget);
  });
}
