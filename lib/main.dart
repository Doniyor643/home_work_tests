import 'package:flutter/material.dart';
import 'package:home_work_tests/pages/create_page.dart';
import 'package:home_work_tests/pages/detail_page.dart';
import 'package:home_work_tests/pages/home_page.dart';
import 'package:home_work_tests/pages/update_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        HomePage.id: (context) => const HomePage(),
        CreatePage.id: (context) => const CreatePage(),
        UpdatePage.id: (context) => UpdatePage(),
        DetailPage.id: (context) => DetailPage(),
      },
    );
  }
}