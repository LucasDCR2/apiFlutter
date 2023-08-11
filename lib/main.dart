import 'package:flutter/material.dart';
import 'package:login/form_screen.dart';
import 'package:login/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FormScreen(),
        '/home':(context) => HomeScreen(),
      },
    );
  }
}
