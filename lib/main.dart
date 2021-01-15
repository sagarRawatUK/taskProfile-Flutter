import 'package:flutter/material.dart';
import 'package:app/views/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(iconTheme: IconThemeData(color: Colors.white)),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
