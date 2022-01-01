import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/providers/auth_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  var _obscureText = true;
  var _obscureTextConfirm = true;
  var _email = "";
  var _firstname = "";
  var _lastname = "";
  var _password = "";
  var _confirmPassword = "";
  var _pseudo = "";
  var _birthday = "";
  var _city = "";
  var _zipCode = "";
  late int _numAddress;
  var _street = "";
  var _country = "France";
  final dateController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
    super.dispose();
  }

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
        vertical: 30,
        horizontal: 30,
      ),
      child: Column(
        children: [
          DelayedAnimation(
            delay: 1000,
            child: TextFormField(
              initialValue: _firstname,
              onChanged: (value) {
                setState(() {
                  _firstname = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Prénom',
                labelStyle: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          DelayedAnimation(
            delay: 1000,
            child: TextFormField(
              initialValue: _lastname,
              onChanged: (value) {
                setState(() {
                  _lastname = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Nom',
                labelStyle: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          DelayedAnimation(
              delay: 1000,
              child: TextField(
                readOnly: true,
                controller: dateController,
                decoration: InputDecoration(
                  labelText: 'Anniversaire',
                  labelStyle: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
                onTap: () async {
                  var date = await showDatePicker(
                      context: context,
                      locale: Locale('fr', 'FR'),
                      initialDate: DateTime.parse("2015-01-01"),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now());
                  dateController.text = date?.toString().substring(0, 10) ?? "";
                },
              )),
          SizedBox(height: 15),
          DelayedAnimation(
            delay: 1000,
            child: TextFormField(
              initialValue: _pseudo,
              onChanged: (value) {
                setState(() {
                  _pseudo = value;
                });
              },
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                labelText: 'Pseudo',
              ),
            ),
          ),
          SizedBox(height: 15),
          DelayedAnimation(
            delay: 1000,
            child: TextFormField(
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
          SizedBox(height: 15),
          DelayedAnimation(
            delay: 1000,
            child: TextFormField(
              initialValue: _password,
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
          SizedBox(height: 15),
          DelayedAnimation(
            delay: 1000,
            child: TextFormField(
              initialValue: _confirmPassword,
              onChanged: (value) {
                setState(() {
                  _confirmPassword = value;
                });
              },
              obscureText: _obscureTextConfirm,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                labelText: 'Confirmez votre mot de passe',
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.visibility,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureTextConfirm = !_obscureTextConfirm;
                    });
                  },
                ),
              ),
            ),
          ),
          DelayedAnimation(
            delay: 1000,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: color_blue,
                    shape: StadiumBorder(),
                    padding: EdgeInsets.all(13)),
                child: Text('Étape suivante'),
                onPressed: () {
                  Navigator.pushNamed(context, '/register/address');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
