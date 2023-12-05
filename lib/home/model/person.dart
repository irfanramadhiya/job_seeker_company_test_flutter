import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 0)
class Person {
  @HiveField(0)
  int id;

  @HiveField(1)
  String email;

  @HiveField(2)
  String firstName;

  @HiveField(3)
  String lastName;

  @HiveField(4)
  String avatar;

  Person(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.avatar});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }

  static List<Person> listFromJson(List<dynamic> list) =>
      List<Person>.from(list.map((e) => Person.fromJson(e)));
}
