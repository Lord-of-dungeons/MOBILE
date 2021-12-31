import 'package:flutter/material.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/providers/user_provider.dart';

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
              FutureBuilder(
                future: UserProvider().getUserPrefs(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData && snapshot.data == false) {
                    // Navigator.pushNamed(context, '/');
                  }

                  return Text("");
                },
              ),
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
