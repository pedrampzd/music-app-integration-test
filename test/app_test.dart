import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:music_app/main.dart' as app;
import 'package:music_app/presentation/pages/home_page.dart';
import 'package:music_app/presentation/widgets/appbar_search_button.dart';
import 'package:get_it/get_it.dart';
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
      await tester.pumpAndSettle();

      // Search for desired music
      await tester.enterText(find.byType(TextField).at(0), 'coldplay');

      // Tap to search for the music
      try {
        await tester.tap(find.byKey(Key('search_button')));
        await tester.pumpAndSettle();
      } catch (e) {
        print('Error during tapping and settling: $e');
        fail('Failed to tap on the search button and settle.');
      }

      expect(find.byType(SearchPage), findsOneWidget);
    });

    testWidgets('Home screen text assertion', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Assert that the app displays the texts correctly
      expect(find.text('No Albums added yet'), findsOneWidget);
      expect(find.text('Music App'), findsOneWidget);
    });

    testWidgets('favorite album, Verify Album Removal from Favorites', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Tap on the AppbarSearchButton
      await tester.tap(find.byType(AppbarSearchButton));
      await tester.pumpAndSettle();

      // Search for desired music
      await tester.enterText(find.byType(TextField).at(0), 'michael jackson');

      // Tap to search for the music
      await tester.tap(find.byKey(Key('search_button')));
      await tester.pumpAndSettle();

      // Tap on a specific artist
      await tester.tap(find.text('Michael Jackson'));
      await tester.pumpAndSettle();

      // Tap the favorite button for the album
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.text('Thriller'),
        ),
        findsOneWidget,
      );

      await tester.tap(find.byKey(const Key('album_favorite_button')).at(0));
      await tester.pumpAndSettle();  // Wait for any animations to complete

      // Simulate navigation
      // Pop twice
      for (int i = 0; i < 2; i++) {
        tester.state<NavigatorState>(find.byType(Navigator)).pop();
        await tester.pumpAndSettle();
      }

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Thriller'), findsOneWidget);

      await tester.tap(find.byKey(const Key('album_favorite_button')));
      await tester.pumpAndSettle();

      // Find all Card widgets
      final cardFinder = find.byType(Card);

      // Count the number of Card widgets
      final cardCount = cardFinder.evaluate().length;

      // Verify the number of Card widgets
      expect(cardCount, equals(0));

      await Future.delayed(const Duration(seconds: 5));
    });
  });
}