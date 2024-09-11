import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:music_app/main.dart' as app;
import 'package:music_app/presentation/pages/home_page.dart';
import 'package:music_app/presentation/widgets/appbar_search_button.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group(
    'integration test E2E',
        () {
      testWidgets(
        'verify home page',
            (tester) async {
          app.main();
          await tester.pumpAndSettle();

          // Verify the presence of widgets
          expect(find.byType(HomePage), findsOneWidget);
          expect(find.byType(AppbarSearchButton), findsOneWidget);

          // Tap on the AppbarSearchButton
          await tester.tap(find.byType(AppbarSearchButton));
          await tester.pumpAndSettle();  // Wait for any animations to complete

          // Search for desired music
          await tester.enterText(find.byType(TextField).at(0), 'coldplay');

          // Tap to search for the music
          await tester.tap(find.byKey(Key('search_button')));
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 20));

          // expect(find.byType(AlbumScreen), findsOneWidget);
        },
      );
    },
  );
}