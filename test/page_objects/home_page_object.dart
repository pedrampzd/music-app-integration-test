import 'package:flutter_test/flutter_test.dart';
import 'package:music_app/presentation/pages/home_page.dart';
import 'package:music_app/presentation/widgets/appbar_search_button.dart';

class HomePageObject {
  final WidgetTester tester;

  HomePageObject(this.tester);

  Future<void> verifyPage() async {
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(AppbarSearchButton), findsOneWidget);
  }

  Future<void> tapSearchButton() async {
    await tester.tap(find.byType(AppbarSearchButton));
    await tester.pumpAndSettle();
  }
}
