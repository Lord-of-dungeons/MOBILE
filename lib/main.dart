import 'package:flutter/material.dart';
import 'package:lordofdungeons/screens/login_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lordofdungeons/utils/route_generator.dart';
import 'package:page_transition/page_transition.dart';

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
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: 'assets/images/logo_start_app.png',
        nextScreen: LoginScreen(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        splashIconSize: double.infinity,
        backgroundColor: Colors.black,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
