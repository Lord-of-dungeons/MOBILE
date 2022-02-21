import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/providers/auth_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _obscureText = true;
  var _password = "";
  var _email = "";

  @override
  void initState() {
    super.initState();

    // on récupère l'utilisateur s'il existe dans le stockage local afin de mettre à journ l'email
    SharedPreferences.getInstance().then((value) {
      final dynamic user = value.getString('user');
      if (user == null) return;
      setState(() {
        _email = jsonDecode(user).email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      child: Column(
        children: [
          DelayedAnimation(
            delay: 750,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              initialValue: _email,
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          DelayedAnimation(
            delay: 750,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                labelText: 'Mot de passe',
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.visibility,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
          ),
          DelayedAnimation(
            delay: 750,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: color_green,
                    shape: StadiumBorder(),
                    padding: EdgeInsets.all(13)),
                child: Text('Go'),
                onPressed: () {
                  AuthProvider().login(context, _email, _password);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
