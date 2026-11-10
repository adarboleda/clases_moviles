import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:consumo_api/data/datasources/item_api.dart';
import 'package:consumo_api/data/repositories/item_repository_impl.dart';
import 'package:consumo_api/domain/usecases/obtener_items.dart';
import 'package:consumo_api/main.dart';
import 'package:consumo_api/presentation/viewmodels/item_viewmodel.dart';

void main() {
  testWidgets('Muestra la pantalla de inicio', (WidgetTester tester) async {
    final useCase = ObtenerItems(ItemRepositoryImpl(ItemApi()));

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ItemViewModel(obtenerItems: useCase),
        child: const MiApp(),
      ),
    );

    expect(find.text('Consumo de API'), findsOneWidget);
    expect(find.text('Consultar API'), findsOneWidget);
  });
}
