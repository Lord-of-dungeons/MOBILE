import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/screens/login_screen.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:http/http.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _obscureText = true;
  var _password = "";
  var _email = "";

  login() async {
    try {
      Response res = await post(Uri.parse('$url_api/auth/login'),
          body: {'email': _email, 'password': _password});

      // si y'a une erreur
      if (res.statusCode != 200) {
        // récupération du body
        var decodedResponse = json.decode(res.body);
        throw (decodedResponse['error']);
      }
      print("gooood");
      // redirection
      Route route = MaterialPageRoute(builder: (context) => LoginScreen());
      Navigator.pushReplacement(context, route);
    } catch (e) {
      print('error $e');
    }
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
            delay: 2500,
            child: TextField(
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
          SizedBox(height: 5),
          DelayedAnimation(
            delay: 2500,
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
            delay: 2500,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: color_green,
                    shape: StadiumBorder(),
                    padding: EdgeInsets.all(13)),
                child: Text('Go'),
                onPressed: login,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
