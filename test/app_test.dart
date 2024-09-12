import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:music_app/main.dart' as app;
import 'package:music_app/presentation/pages/home_page.dart';
import 'package:music_app/presentation/widgets/appbar_search_button.dart';
import 'package:get_it/get_it.dart';  // Import GetIt
import 'package:music_app/presentation/widgets/album_widget.dart';
import 'package:music_app/presentation/pages/search_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Reset GetIt before each test
  setUp(() {
    GetIt.instance.reset();
  });

  group('integration test E2E', () {
    testWidgets('verify home page and search for music', (tester) async {
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
      expect(find.byType(SearchPage), findsOneWidget);

    });

    testWidgets('Home screen text assertion', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Assert that the app shows the "No Albums added yet" message
      expect(find.text('No Albums added yet'), findsOneWidget);  // Replace with actual message if necessary
    });

    testWidgets('favorite album', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Tap on the AppbarSearchButton
      await tester.tap(find.byType(AppbarSearchButton));
      await tester.pumpAndSettle();  // Wait for any animations to complete

      // Search for desired music
      await tester.enterText(find.byType(TextField).at(0), 'michael jackson');

      // Tap to search for the music
      await tester.tap(find.byKey(Key('search_button')));
      await tester.pumpAndSettle();

      // Tap on a specific artist
      await tester.tap(find.text('Michael Jackson & Janet Jackson'));
      await tester.pumpAndSettle();

      // Tap the favorite button for the album
      await tester.tap(find.byKey(const Key('album_favorite_button')).at(0));
      await tester.pumpAndSettle();  // Wait for any animations to complete
    });
  });
}