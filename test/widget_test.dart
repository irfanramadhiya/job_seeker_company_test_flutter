// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:job_seeker_company_test/home/model/person.dart';
import 'package:job_seeker_company_test/home/view/home_view.dart';
import 'package:job_seeker_company_test/home/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

late Box box;
void main() {
  setUp(() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PersonAdapter());
    box = await Hive.openBox('hiveBox');
  });
  testWidgets('Search a person', (WidgetTester tester) async {
    final search = find.byKey(ValueKey("search"));

    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => HomeViewModel(box)),
    ], child: const MaterialApp(home: HomeView())));
    await tester.enterText(search, "michael");
    await tester.pump();

    expect(find.text("Michael"), findsOneWidget);
  });
}
