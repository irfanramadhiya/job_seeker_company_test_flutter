import 'package:flutter/material.dart';
import 'package:job_seeker_company_test/api/service.dart';

class AddPersonViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController avatarLinkController = TextEditingController();
  String successMsg = "";

  String? checkFirstName(String? value) {
    if (value!.isEmpty) {
      return "First Name can't be empty";
    } else {
      return null;
    }
  }

  String? checkLastName(String? value) {
    if (value!.isEmpty) {
      return "Last Name can't be empty";
    } else {
      return null;
    }
  }

  String? checkEmail(String? value) {
    if (value!.isEmpty) {
      return "E-mail can't be empty";
    } else {
      return null;
    }
  }

  String? checkAvatarLink(String? value) {
    if (value!.isEmpty) {
      return "Avatar Link can't be empty";
    } else {
      return null;
    }
  }

  addPressed(BuildContext context) async {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              )); // show loading
      String newPersonName = await Service().postCreateUser(
          firstNameController.text,
          lastNameController.text,
          emailController.text,
          avatarLinkController.text);
      Navigator.of(context).pop(); // dismiss loading
      successMsg = "Person $newPersonName has been added!";
      notifyListeners();
    }
  }

  returnToHome(BuildContext context) {
    Navigator.pop(context);
  }
}
