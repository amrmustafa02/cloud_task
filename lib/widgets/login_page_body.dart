import 'package:cloud_task/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../pages/notification_page.dart';

class LoginPageBody extends StatefulWidget {
  LoginPageBody({super.key});

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  final TextEditingController nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * .70,
              child: TextFormField(
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Please Enter your name";
                  }
                  return null;
                },
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Enter Your Name",
                  enabledBorder: getBorderStyle(),
                  focusedBorder: getBorderStyle(),
                  errorBorder: getBorderStyle(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: size.width / 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {
                  clickOnNextStorage();
                },
                child: const Text("Next To Storage"),
              ),
            ),
            SizedBox(
              width: size.width / 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {
                  clickOnNextMessaging();
                },
                child: const Text("Next To Messaging"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder getBorderStyle({Color color = Colors.green}) =>
      OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: color, width: 2));

  clickOnNextStorage() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            userName: nameController.text,
          ),
        ));

    // go to send name to next screen
  }

  clickOnNextMessaging() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const NotificationPage(),
      ),
    );

    // go to send name to next screen
  }
}
