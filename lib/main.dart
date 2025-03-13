import 'package:flutter/material.dart';
import 'package:map_app/screens/map_screen.dart';
import 'package:map_app/screens/wait_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WaitScreen(),
    );
  }
}

