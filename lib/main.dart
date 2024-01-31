import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});//change

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title : "MOVIE APP",
      home: HomeScreen(),
    );
  }
}
