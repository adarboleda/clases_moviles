import 'package:flutter_test/flutter_test.dart';

import 'package:pry009_image_picker/main.dart';
import 'package:pry009_image_picker/providers/foto_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Navega entre las pestañas', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => FotoProvider(),
        child: const MyApp(),
      ),
    );

    expect(find.text('Bienvenido a la aplicación de fotos'), findsOneWidget);

    await tester.tap(find.text('Perfil'));
    await tester.pumpAndSettle();
    expect(find.text('Bienvenido al perfil de usuario'), findsOneWidget);

    await tester.tap(find.text('Fotos'));
    await tester.pumpAndSettle();
    expect(find.text('Aún no has tomado fotos'), findsOneWidget);
  });
}
