import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:job_seeker_company_test/add_person/view/add_person_view.dart';
import 'package:job_seeker_company_test/home/model/person.dart';
import 'package:job_seeker_company_test/api/service.dart';

class HomeViewModel extends ChangeNotifier {
  final Box box;
  final TextEditingController searchController = TextEditingController();
  List<Person>? persons = [];
  Person firstPerson = Person(
      id: 0,
      email: "email",
      firstName: "firstName",
      lastName: "lastName",
      avatar: "avatar");

  HomeViewModel(this.box);

  Future<List<Person>?> initData(BuildContext context) async {
    persons = await Service().getListUsers(context);
    firstPerson = await Service().getUserById(1);

    if (persons != null) {
      box.put("personList", persons);
    }
    persons = List.from(getPersonList()!);
    return persons;
  }

  List<Person>? getPersonList() {
    if (box.get('personList')?.cast<Person>() != null) {
      return box.get('personList')?.cast<Person>();
    }
    return [];
  }

  navigateToAddPerson(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => AddPersonView()));
  }

  createBuilder(AsyncSnapshot<List<Person>?> snapshot, BuildContext context) {
    if (snapshot.hasError) {
      return Center(child: Text(snapshot.error.toString()));
    } else if (snapshot.hasData) {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text("Welcome ${firstPerson.firstName} ${firstPerson.lastName}!"),
            Expanded(
                child: ListView.builder(
              itemCount: persons?.length ?? 0,
              itemBuilder: (context, index) {
                final person = persons?[index];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(person?.avatar ?? ""),
                    ),
                    title: Text(
                        "${person?.firstName ?? ""} ${person?.lastName ?? ""}"),
                    subtitle: Text(person?.email ?? ""),
                  ),
                );
              },
            )),
          ],
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  search() {
    persons = List.from(getPersonList()!);
    String searchText = searchController.text.toString();
    if (searchText != '') {
      for (var i = 0; i < persons!.length; i++) {
        String name =
            "${persons![i].firstName.toLowerCase()} ${persons![i].lastName.toLowerCase()}";
        if (!name.contains(searchText)) {
          persons!.removeAt(i);
          i--;
        }
      }
    }
    notifyListeners();
  }
}
