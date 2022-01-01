import 'package:flutter/material.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/providers/auth_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:lordofdungeons/widgets/form/register_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
    AuthProvider().autoLogIn(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_green,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: BodyRegisterScreen()),
    );
  }
}

class BodyRegisterScreen extends StatelessWidget {
  const BodyRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      child: Column(
        children: [
          DelayedAnimation(
            delay: 250,
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/gobelin.png",
                width: 200,
              ),
            ),
          ),
          DelayedAnimation(
            delay: 500,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              alignment: Alignment.center,
              child: Text(
                'Inscrivez-vous pour rejoindre le combat !',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Bungee', fontSize: 18, color: Colors.black),
              ),
            ),
          ),
          // ######################################################
          //                    LOGIN FORM
          // ######################################################
          RegisterForm(),
          // ######################################################
          // ######################################################
        ],
      ),
    );
  }
}
