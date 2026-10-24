import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tarea1_2/controlador/pago_controlador.dart';
import 'package:tarea1_2/main.dart';
import 'package:tarea1_2/modelo/consumo_modelo.dart';
import 'package:tarea1_2/modelo/tipo_consumidor.dart';

void main() {
  group('PagoControlador', () {
    final controlador = PagoControlador();

    test('selecciona la tarifa según el rango de consumo', () {
      expect(controlador.obtenerTarifa(0).nombre, 'Básica');
      expect(controlador.obtenerTarifa(15).nombre, 'Básica');
      expect(controlador.obtenerTarifa(16).nombre, 'Intermedia');
      expect(controlador.obtenerTarifa(30).nombre, 'Intermedia');
      expect(controlador.obtenerTarifa(31).nombre, 'Superior');
    });

    test('calcula pago residencial sin recargo', () {
      final pago = controlador.calcularPago(
        const ConsumoModelo(
          numeroCuenta: '123456',
          nombreCliente: 'Ana Pérez',
          lecturaAnterior: 100,
          lecturaActual: 120,
          tipo: TipoConsumidor.residencial,
        ),
      );
      expect(pago.consumo, 20);
      expect(pago.valorConsumo, 14.00);
      expect(pago.subtotal, 17.00);
      expect(pago.recargo, 0.00);
      expect(pago.total, 17.00);
    });

    test('calcula pago comercial con recargo', () {
      final pago = controlador.calcularPago(
        const ConsumoModelo(
          numeroCuenta: '123456',
          nombreCliente: 'Tienda Luz',
          lecturaAnterior: 0,
          lecturaActual: 40,
          tipo: TipoConsumidor.comercial,
        ),
      );
      expect(pago.valorConsumo, 42.00);
      expect(pago.subtotal, 48.00);
      expect(pago.recargo, 4.80);
      expect(pago.total, 52.80);
    });

    test('valida que la lectura actual no sea menor a la anterior', () {
      expect(controlador.validarLecturaActual('50', '80'), isNotNull);
      expect(controlador.validarLecturaActual('80', '80'), isNull);
    });
  });

  testWidgets('login inválido muestra validaciones y mensaje', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Ingresar'));
    await tester.pump();
    expect(find.text('Ingrese su usuario'), findsOneWidget);
    expect(find.text('Ingrese su contraseña'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Usuario'),
      'admin',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Contraseña'),
      '9999',
    );
    await tester.tap(find.text('Ingresar'));
    await tester.pump();
    expect(find.text('Usuario o contraseña incorrectos'), findsOneWidget);
  });

  testWidgets('flujo completo: login, registro y detalle de pago', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(500, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MyApp());

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Usuario'),
      'admin',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Contraseña'),
      '1234',
    );
    await tester.tap(find.text('Ingresar'));
    await tester.pumpAndSettle();
    expect(find.text('Registro de consumo'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Número de cuenta'),
      '123456',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nombre del cliente'),
      'Tienda Luz',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Lectura anterior'),
      '0',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Lectura actual'),
      '40',
    );
    await tester.tap(find.byType(DropdownButtonFormField<TipoConsumidor>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Comercial').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Calcular pago'));
    await tester.pumpAndSettle();

    expect(find.text('Detalle de pago'), findsOneWidget);
    expect(find.text('\$52.80'), findsNWidgets(2));

    await tester.tap(find.text('Confirmar pago'));
    await tester.pumpAndSettle();
    expect(find.text('Pago registrado'), findsOneWidget);

    await tester.tap(find.text('Aceptar'));
    await tester.pumpAndSettle();

    // Regresa al registro con el formulario limpio
    expect(find.text('Registro de consumo'), findsOneWidget);
    expect(find.text('Tienda Luz'), findsNothing);
  });
}
