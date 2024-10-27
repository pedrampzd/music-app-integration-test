import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:music_app/main.dart' as app;
import 'page_objects/home_page_object.dart';
import 'page_objects/search_page_object.dart';
import 'page_objects/album_page_object.dart';
import 'package:get_it/get_it.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    GetIt.instance.reset();
  });

  group('integration test E2E', () {
    testWidgets('verify home page and search for music', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final homePage = HomePageObject(tester);
      await homePage.verifyPage();
      await homePage.tapSearchButton();

      final searchPage = SearchPageObject(tester);
      await searchPage.searchForMusic('coldplay');
      await searchPage.verifySearchPage();
    });

    testWidgets('Home screen text assertion', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final homePage = HomePageObject(tester);
      await homePage.verifyPage();

      // Assert that the app displays the texts correctly
      expect(find.text('No Albums added yet'), findsOneWidget);
      expect(find.text('Music App'), findsOneWidget);
    });

    testWidgets('favorite album, Verify Album Removal from Favorites', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final homePage = HomePageObject(tester);
      await homePage.tapSearchButton();

      final searchPage = SearchPageObject(tester);
      await searchPage.searchForMusic('michael jackson');
      await searchPage.selectArtist('Michael Jackson');

      final albumPage = AlbumPageObject(tester);
      await albumPage.favoriteAlbum('Thriller');

      // Simulate navigation
      for (int i = 0; i < 2; i++) {
        tester.state<NavigatorState>(find.byType(Navigator)).pop();
        await tester.pumpAndSettle();
      }

      await homePage.verifyPage();
      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Thriller'), findsOneWidget);

      await albumPage.removeAlbumFromFavorites();

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
