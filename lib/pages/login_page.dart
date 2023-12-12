import 'package:cloud_task/widgets/login_page_body.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cloud Task"),
        centerTitle: true,
        backgroundColor: Colors.green,
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(
              15,
            )),
      ),
      body: LoginPageBody(),
    );
  }
}
