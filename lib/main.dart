import 'package:flutter/material.dart';

import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al Quran Audio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AppView(),
    );
  }
}
