import 'package:flutter/material.dart';
import 'package:job_seeker_company_test/home/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            key: Key("plusIcon"),
            icon: const Icon(Icons.add),
            onPressed: () {
              context.read<HomeViewModel>().navigateToAddPerson(context);
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              key: Key("searchField"),
              controller: Provider.of<HomeViewModel>(context, listen: false)
                  .searchController,
              decoration: const InputDecoration(
                hintText: 'Find a person',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                context.read<HomeViewModel>().search();
              },
            ),
            FutureBuilder(
              future: context.read<HomeViewModel>().initData(context),
              builder: (context, snapshot) {
                return Provider.of<HomeViewModel>(context, listen: true)
                    .createBuilder(snapshot, context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
