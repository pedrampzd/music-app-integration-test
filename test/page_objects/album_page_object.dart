import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

class AlbumPageObject {
  final WidgetTester tester;

  AlbumPageObject(this.tester);

  Future<void> favoriteAlbum(String albumName) async {
    expect(
      find.descendant(
        of: find.byType(Card),
        matching: find.text(albumName),
      ),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const Key('album_favorite_button')).at(0));
    await tester.pumpAndSettle();
  }

  Future<void> removeAlbumFromFavorites() async {
    await tester.tap(find.byKey(const Key('album_favorite_button')));
    await tester.pumpAndSettle();
  }
}
