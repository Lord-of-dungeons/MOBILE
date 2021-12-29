import 'package:flutter/material.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 20,
          ),
          child: Column(
            children: [
              DelayedAnimation(
                delay: 1000,
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logo_fond_blanc.png",
                    width: 175,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
