import 'package:chat_app/screens/home/home.dart';
import 'package:chat_app/screens/login/login.dart';
import 'package:chat_app/screens/register/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/home': (context) => Home(),
        '/register': (context) => Register(),
      },
    );
  }
}
