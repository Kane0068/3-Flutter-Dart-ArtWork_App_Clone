import 'package:flutter/material.dart';
import 'package:flutter_artwork/home_page.dart';
import 'package:flutter_artwork/login.dart';
import 'package:flutter_artwork/sign_up.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: HomePage(name: "name"),
    );
  }
}
