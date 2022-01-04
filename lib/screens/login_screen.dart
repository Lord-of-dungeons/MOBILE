import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/providers/auth_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:lordofdungeons/widgets/form/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    AuthProvider().autoLogIn(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: AuthProvider().autoLogIn(context),
              builder: (context, snapshot) {
                return BodyLoginScreen();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BodyLoginScreen extends StatelessWidget {
  const BodyLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 20,
      ),
      child: Column(
        children: [
          DelayedAnimation(
            delay: 250,
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/logo_fond_blanc.png",
                width: 150,
              ),
            ),
          ),
          DelayedAnimation(
            delay: 500,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Bungee', fontSize: 18, color: Colors.black),
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
            delay: 1750,
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
                  Navigator.pushNamed(context, '/register/informations');
                },
              ),
            ),
          ),
          DelayedAnimation(
            delay: 3000,
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
                  onPressed: () async {
                    AuthProvider().loginFacebook(context);
                  }),
            ),
          ),
          DelayedAnimation(
            delay: 3500,
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
                  AuthProvider().loginGoogle(context);
                },
              ),
            ),
          ),
          DelayedAnimation(
            delay: 4000,
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
                      builder: (context) => LoginScreen(),
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
    );
  }
}
