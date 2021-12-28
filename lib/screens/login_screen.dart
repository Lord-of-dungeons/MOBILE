import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:lordofdungeons/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                delay: 1500,
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logo_fond_blanc.png",
                    width: 175,
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
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ),
              ),
              // ######################################################
              //                    LOGIN FORM
              // ######################################################
              LoginForm(),
              // ######################################################
              // ######################################################

              // ######################################################
              //                   PAS DE COMPTE
              // ######################################################
              DelayedAnimation(
                delay: 2500,
                child: Container(
                    margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                    child: Text('Vous n\'avez pas encore de compte ?')),
              ),
              DelayedAnimation(
                delay: 2500,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 20,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: StadiumBorder(),
                        padding: EdgeInsets.all(10),
                        shadowColor: color_red),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.envelope,
                          color: color_red,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Email',
                          style: TextStyle(
                            color: color_red,
                            fontSize: 14,
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
                    horizontal: 20,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF0178EE),
                      shape: StadiumBorder(),
                      padding: EdgeInsets.all(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.facebook),
                        SizedBox(width: 20),
                        Text(
                          'Facebook',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
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
                    horizontal: 20,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFF371D),
                        shape: StadiumBorder(),
                        padding: EdgeInsets.all(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.google),
                        SizedBox(width: 20),
                        Text(
                          'Google',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
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
                    horizontal: 20,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: StadiumBorder(),
                        padding: EdgeInsets.all(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.github),
                        SizedBox(width: 20),
                        Text(
                          'Github',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
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
              // ######################################################
              // ######################################################
            ],
          ),
        ),
      ),
    );
  }
}
