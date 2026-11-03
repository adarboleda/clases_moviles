import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:tarea1_3/main.dart';
import 'package:tarea1_3/model/categoria_model.dart';
import 'package:tarea1_3/model/entrega_model.dart';
import 'package:tarea1_3/model/producto_model.dart';
import 'package:tarea1_3/view_model/pedido_viewmodel.dart';

ProductoModel producto(String id) =>
    ProductoModel.catalogo.firstWhere((p) => p.id == id);

void main() {
  group('PedidoViewModel', () {
    test('agrega productos y acumula cantidades y total', () {
      final vm = PedidoViewModel();
      vm.agregar(producto('p1')); // 6.50
      vm.agregar(producto('p1'));
      vm.agregar(producto('b1')); // 1.75

      expect(vm.cantidadDe(producto('p1')), 2);
      expect(vm.totalArticulos, 3);
      expect(vm.subtotal, closeTo(14.75, 0.001));
      expect(vm.total, closeTo(14.75, 0.001));
    });

    test('disminuir quita el producto al llegar a cero', () {
      final vm = PedidoViewModel();
      vm.agregar(producto('d2'));
      vm.disminuir(producto('d2'));
      expect(vm.carritoVacio, isTrue);
    });

    test('no supera la cantidad máxima por producto', () {
      final vm = PedidoViewModel();
      for (var i = 0; i < PedidoViewModel.cantidadMaxima; i++) {
        vm.agregar(producto('b1'));
      }
      expect(vm.agregar(producto('b1')), isFalse);
      expect(vm.cantidadDe(producto('b1')), PedidoViewModel.cantidadMaxima);
    });

    test('recorre las categorías sin salirse de los extremos', () {
      final vm = PedidoViewModel();
      expect(vm.categoriaAnterior(), isFalse);
      expect(vm.siguienteCategoria(), isTrue);
      expect(vm.categoriaSeleccionada, CategoriaModel.bebidas);
      expect(vm.siguienteCategoria(), isTrue);
      expect(vm.siguienteCategoria(), isFalse);
      expect(vm.categoriaSeleccionada, CategoriaModel.postres);
      expect(
        vm.productos.every((p) => p.categoria == CategoriaModel.postres),
        isTrue,
      );
    });

    test('suma el costo de entrega al total', () {
      final vm = PedidoViewModel();
      vm.agregar(producto('p4')); // 7.25
      vm.cambiarEntrega(EntregaModel.domicilio); // 2.00
      expect(vm.total, closeTo(9.25, 0.001));
      vm.vaciar();
      expect(vm.total, 0);
      expect(vm.entrega, EntregaModel.local);
    });

    test('valida el nombre del cliente', () {
      final vm = PedidoViewModel();
      expect(vm.validarCliente(''), isNotNull);
      expect(vm.validarCliente('Ana 1'), isNotNull);
      expect(vm.validarCliente('Ana López'), isNull);
    });
  });

  testWidgets('splash, gestos del menú y carrito con paso de parámetros', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(420, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => PedidoViewModel(),
        child: const MyApp(),
      ),
    );

    //splash: animacion y paso automatico al menu
    expect(find.text('El Buen Sabor'), findsOneWidget);
    //termina la animacion y luego la espera antes de ir al menu
    await tester.pumpAndSettle();
    expect(find.text('Menú'), findsNothing);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Menú'), findsOneWidget);
    expect(find.text('Hamburguesa clásica'), findsOneWidget);

    //gesto 1: deslizar hacia la izquierda muestra las bebidas
    await tester.fling(
      find.text('Hamburguesa clásica'),
      const Offset(-300, 0),
      1000,
    );
    await tester.pumpAndSettle();
    expect(find.text('Limonada'), findsOneWidget);
    expect(find.text('Hamburguesa clásica'), findsNothing);

    //gesto 2: arrastrar la limonada hasta la zona del carrito
    final gesto = await tester.startGesture(
      tester.getCenter(find.text('Limonada')),
    );
    await tester.pump(const Duration(milliseconds: 500));
    await gesto.moveTo(
      tester.getCenter(find.text('Arrastra aquí tus productos')),
    );
    await tester.pump();
    expect(find.text('Suelta para agregar'), findsOneWidget);
    await gesto.up();
    await tester.pumpAndSettle();
    expect(find.text('x1'), findsOneWidget);
    expect(find.text('Total: \$1.75'), findsOneWidget);

    //sin nombre no se puede ver el carrito
    await tester.tap(find.text('Ver carrito'));
    await tester.pump();
    expect(find.text('Ingrese el nombre del cliente'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Ana López');
    await tester.tap(find.text('Ver carrito'));
    await tester.pumpAndSettle();

    //el nombre llega como argumento a la pantalla del carrito
    expect(find.text('Carrito'), findsOneWidget);
    expect(find.text('Ana López'), findsOneWidget);

    await tester.tap(find.byTooltip('Agregar uno'));
    await tester.tap(find.text('A domicilio'));
    await tester.pumpAndSettle();
    //2 limonadas (3.50) + domicilio (2.00)
    expect(find.text('\$5.50'), findsOneWidget);

    await tester.ensureVisible(find.text('Confirmar pedido'));
    await tester.tap(find.text('Confirmar pedido'));
    await tester.pumpAndSettle();
    expect(find.text('Pedido confirmado'), findsOneWidget);

    await tester.tap(find.text('Aceptar'));
    await tester.pumpAndSettle();
    expect(find.text('Menú'), findsOneWidget);
    expect(find.text('Total: \$0.00'), findsOneWidget);
  });
}
