import 'package:flutter/material.dart';
import 'package:lordofdungeons/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lord of Dungeons',
        // Set Raleway as the default app font.
        theme: ThemeData(fontFamily: 'Montserrat'),
        home: LoginScreen());
  }
}
