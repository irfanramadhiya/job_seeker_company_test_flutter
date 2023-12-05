import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:integration_test/integration_test.dart';
import 'package:job_seeker_company_test/add_person/viewmodel/add_person_viewmodel.dart';
import 'package:job_seeker_company_test/home/model/person.dart';
import 'package:job_seeker_company_test/home/view/home_view.dart';
import 'package:job_seeker_company_test/home/viewmodel/home_viewmodel.dart';
import 'package:job_seeker_company_test/main.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(PersonAdapter());
    }
    box = await Hive.openBox('hiveBox');
  });

  testWidgets('add a person', (tester) async {
    final plusIcon = find.byKey(ValueKey("plusIcon"));
    final firstNameField = find.byKey(ValueKey("firstNameField"));
    final lastNameField = find.byKey(ValueKey("lastNameField"));
    final emailField = find.byKey(ValueKey("emailField"));
    final avatarLinkField = find.byKey(ValueKey("avatarLinkField"));
    final addButton = find.byKey(ValueKey("addButton"));

    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => HomeViewModel(box)),
      ChangeNotifierProvider(create: (_) => AddPersonViewModel())
    ], child: const MaterialApp(home: HomeView())));
    await tester.tap(plusIcon);
    await tester.pumpAndSettle();
    await tester.enterText(firstNameField, "irfan");
    await tester.enterText(lastNameField, "ramadhiya");
    await tester.enterText(emailField, "irfanramadhiya@gmail.com");
    await tester.enterText(avatarLinkField, "irfan.com/profile.jpg");
    await tester.tap(addButton);
    await tester.pumpAndSettle();
    await tester.pump();

    expect(find.text("Person irfan has been added!"), findsOneWidget);
  });

  testWidgets('add a person with an empty first name', (tester) async {
    final plusIcon = find.byKey(ValueKey("plusIcon"));
    final lastNameField = find.byKey(ValueKey("lastNameField"));
    final emailField = find.byKey(ValueKey("emailField"));
    final avatarLinkField = find.byKey(ValueKey("avatarLinkField"));
    final addButton = find.byKey(ValueKey("addButton"));

    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => HomeViewModel(box)),
      ChangeNotifierProvider(create: (_) => AddPersonViewModel())
    ], child: const MaterialApp(home: HomeView())));
    await tester.tap(plusIcon);
    await tester.pumpAndSettle();
    await tester.enterText(lastNameField, "ramadhiya");
    await tester.enterText(emailField, "irfanramadhiya@gmail.com");
    await tester.enterText(avatarLinkField, "irfan.com/profile.jpg");
    await tester.tap(addButton);
    await tester.pumpAndSettle();
    await tester.pump();

    expect(find.text("First Name can't be empty"), findsOneWidget);
  });

  testWidgets('Search a person', (tester) async {
    final searchField = find.byKey(ValueKey("searchField"));

    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => HomeViewModel(box)),
    ], child: const MaterialApp(home: HomeView())));
    await tester.enterText(searchField, "michael lawson");
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text("Michael Lawson"), findsOneWidget);
  });

  testWidgets('navigating back and forth', (tester) async {
    final plusIcon = find.byKey(ValueKey("plusIcon"));
    final backToHomeButton = find.byKey(ValueKey("backToHomeButton"));

    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => HomeViewModel(box)),
      ChangeNotifierProvider(create: (_) => AddPersonViewModel())
    ], child: const MaterialApp(home: HomeView())));

    await tester.tap(plusIcon);
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text("Add Person"), findsOneWidget);

    await tester.tap(backToHomeButton);
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text("Home"), findsOneWidget);
  });
}
