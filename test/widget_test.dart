import 'package:flutter_test/flutter_test.dart';

import 'package:rueda_app/main.dart';

void main() {
  testWidgets('Home screen navigation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app has the welcome text.
    expect(find.text('Bienvenido a Rueda App'), findsOneWidget);
    expect(find.text('Abrir Círculo de Emociones'), findsOneWidget);

    // Tap the button to open emotions circle.
    await tester.tap(find.text('Abrir Círculo de Emociones'));
    await tester.pumpAndSettle();

    // Verify that we navigated to the emotions screen.
    expect(find.text('Círculo de Emociones'), findsOneWidget);
    expect(find.text('Emociones Principales'), findsOneWidget);
  });
}
