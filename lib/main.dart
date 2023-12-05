import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:job_seeker_company_test/add_person/viewmodel/add_person_viewmodel.dart';
import 'package:job_seeker_company_test/home/model/person.dart';
import 'package:job_seeker_company_test/home/view/home_view.dart';
import 'package:job_seeker_company_test/home/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';

late Box box;
Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  box = await Hive.openBox('hiveBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel(box)),
        ChangeNotifierProvider(create: (_) => AddPersonViewModel())
      ],
      child: MaterialApp(
        title: 'Jobseeker Company',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeView(),
      ),
    );
  }
}
