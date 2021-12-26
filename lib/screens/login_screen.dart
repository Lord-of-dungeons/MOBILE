import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/utils/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 60,
            horizontal: 30,
          ),
          child: Column(
            children: [
              DelayedAnimation(
                delay: 1500,
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logo_fond_blanc.png",
                    width: 250,
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 2000,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Bienvenue dans l\'univers\nLord of Dungeons',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Bungee',
                        fontSize: 22,
                        color: Colors.black),
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 2500,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 60,
                    horizontal: 30,
                  ),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: color_green,
                        // shape: StadiumBorder(),
                        padding: EdgeInsets.all(13)),
                    child: Text('Go'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => this,
                        ),
                      );
                    },
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 2500,
                child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 30,
                    ),
                    child: Text('Vous n\'avez pas encore de compte ?')),
              ),
              DelayedAnimation(
                delay: 2500,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 30,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF0178EE),
                        // shape: StadiumBorder(),
                        padding: EdgeInsets.all(13)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.facebook),
                        SizedBox(width: 20),
                        Text(
                          'Facebook',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => this,
                        ),
                      );
                    },
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 2500,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 30,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFF371D),
                        // shape: StadiumBorder(),
                        padding: EdgeInsets.all(13)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.google),
                        SizedBox(width: 20),
                        Text(
                          'Google',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => this,
                        ),
                      );
                    },
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 2500,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 30,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        // shape: StadiumBorder(),
                        padding: EdgeInsets.all(13)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.github),
                        SizedBox(width: 20),
                        Text(
                          'Github',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => this,
                        ),
                      );
                    },
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
