import 'package:flutter_test/flutter_test.dart';
import 'package:music_app/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';

class SearchPageObject {
  final WidgetTester tester;

  SearchPageObject(this.tester);

  Future<void> searchForMusic(String query) async {
    await tester.enterText(find.byType(TextField).at(0), query);
    await tester.tap(find.byKey(Key('search_button')));
    await tester.pumpAndSettle();
  }

  Future<void> verifySearchPage() async {
    expect(find.byType(SearchPage), findsOneWidget);
  }

  Future<void> selectArtist(String artistName) async {
    await tester.tap(find.text(artistName));
    await tester.pumpAndSettle();
  }
}
