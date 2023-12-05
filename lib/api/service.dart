import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:job_seeker_company_test/home/model/person.dart';

class Service {
  var baseUrl = "https://reqres.in";

  Future<List<Person>?> getListUsers(BuildContext context) async {
    try {
      var response = await Dio().get('$baseUrl/api/users?page=2');

      try {
        return Person.listFromJson(response.data['data']);
      } catch (e) {
        print(e);
        return null;
      }
    } on DioException catch (e) {
      print(e);
      return null;
    }
  }

  Future<Person> getUserById(int id) async {
    try {
      var response = await Dio().get('$baseUrl/api/users/$id');

      try {
        return Person.fromJson(response.data['data']);
      } catch (e) {
        print(e);
        return Person(
            id: id,
            email: "email",
            firstName: "firstName",
            lastName: "lastName",
            avatar: "avatar");
      }
    } catch (e) {
      print(e);
      return Person(
          id: id,
          email: "email",
          firstName: "firstName",
          lastName: "lastName",
          avatar: "avatar");
    }
  }

  Future<String> postCreateUser(String firstName, String lastName, String email,
      String avatarLink) async {
    try {
      var response = await Dio().post('$baseUrl/api/users', data: {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "avatar": avatarLink
      });
      try {
        return response.data["first_name"];
      } catch (e) {
        print(e);
        return "";
      }
    } on DioException catch (e) {
      print(e);
      return "";
    }
  }
}
