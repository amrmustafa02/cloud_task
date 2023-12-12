import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/home_page_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi, $userName"),
        centerTitle: true,
        backgroundColor: Colors.green,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
      ),
      body:  HomePageBody(userName:userName,),
    );
  }
}
