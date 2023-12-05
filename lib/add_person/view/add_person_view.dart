import 'package:flutter/material.dart';
import 'package:job_seeker_company_test/add_person/viewmodel/add_person_viewmodel.dart';
import 'package:provider/provider.dart';

class AddPersonView extends StatelessWidget {
  const AddPersonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add Person"),
      ),
      body: Form(
        key: context.read<AddPersonViewModel>().formKey,
        child: Container(
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            TextFormField(
              key: Key("firstNameField"),
              controller:
                  context.read<AddPersonViewModel>().firstNameController,
              decoration: const InputDecoration(
                labelText: "First Name",
              ),
              validator: (value) {
                return context.read<AddPersonViewModel>().checkFirstName(value);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              key: Key("lastNameField"),
              controller: context.read<AddPersonViewModel>().lastNameController,
              decoration: const InputDecoration(
                labelText: "Last Name",
              ),
              validator: (value) {
                return context.read<AddPersonViewModel>().checkLastName(value);
              },
            ),
            TextFormField(
              key: Key("emailField"),
              controller: context.read<AddPersonViewModel>().emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
              validator: (value) {
                return context.read<AddPersonViewModel>().checkEmail(value);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              key: Key("avatarLinkField"),
              controller:
                  context.read<AddPersonViewModel>().avatarLinkController,
              decoration: const InputDecoration(
                labelText: "Avatar Link",
              ),
              validator: (value) {
                return context
                    .read<AddPersonViewModel>()
                    .checkAvatarLink(value);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              Provider.of<AddPersonViewModel>(context, listen: true).successMsg,
              style: const TextStyle(color: Colors.green),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 48,
              child: TextButton(
                  key: Key("addButton"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff45CDDC)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)))),
                  onPressed: () async {
                    context.read<AddPersonViewModel>().addPressed(context);
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                key: Key("backToHomeButton"),
                onTap: () {
                  context.read<AddPersonViewModel>().returnToHome(context);
                },
                child: const Text(
                  'Back to home',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff45CDDC),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xff45CDDC),
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
