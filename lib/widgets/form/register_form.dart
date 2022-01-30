import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final emailController = TextEditingController(text: "");
  final firstnameController = TextEditingController(text: "");
  final lastnameController = TextEditingController(text: "");
  final dateController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");
  final confirmPasswordController = TextEditingController(text: "");
  final pseudoController = TextEditingController(text: "");

  var _obscureText = true;
  var _obscureTextConfirm = true;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
    emailController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    pseudoController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          List<Widget> children = [
            DelayedAnimation(
              delay: 1000,
              child: TextFormField(
                controller: firstnameController,
                autocorrect: false,
                onChanged: (value) {
                  firstnameController.text = value;
                  firstnameController.selection = TextSelection.fromPosition(
                      TextPosition(offset: value.length));
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
                controller: lastnameController,
                autocorrect: false,
                onChanged: (value) {
                  lastnameController.text = value;
                  lastnameController.selection = TextSelection.fromPosition(
                      TextPosition(offset: value.length));
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
                    dateController.text =
                        date?.toString().substring(0, 10) ?? "";
                  },
                )),
            SizedBox(height: 15),
            DelayedAnimation(
              delay: 1000,
              child: TextFormField(
                controller: pseudoController,
                autocorrect: false,
                onChanged: (value) {
                  pseudoController.text = value;
                  pseudoController.selection = TextSelection.fromPosition(
                      TextPosition(offset: value.length));
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
                controller: emailController,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  emailController.text = value;
                  emailController.selection = TextSelection.fromPosition(
                      TextPosition(offset: value.length));
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ),
          ];
          // ##############################################################
          //        Récupération des données du stockage locale
          // ##############################################################
          if (snapshot.hasData) {
            final dynamic user = snapshot.data!.getString('register_form');
            if (user != null) {
              final data = jsonDecode(user);
              emailController.text = data["email"] ?? "";
              firstnameController.text = data["firstname"] ?? "";
              lastnameController.text = data["lastname"] ?? "";
              // dateController.text = data["birthday"] ?? "";
              pseudoController.text = data["pseudo"] ?? "";

              //
              // si c'est une inscription normale on ajoute les mots de passe
              //
              if (data["google_id"] == null &&
                  data["facebook_id"] == null &&
                  data["github_id"] == null) {
                children.addAll([
                  SizedBox(height: 15),
                  DelayedAnimation(
                    delay: 1000,
                    child: TextFormField(
                      controller: passwordController,
                      autocorrect: false,
                      onChanged: (value) {
                        passwordController.text = value;
                        passwordController.selection =
                            TextSelection.fromPosition(
                                TextPosition(offset: value.length));
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
                      controller: confirmPasswordController,
                      autocorrect: false,
                      onChanged: (value) {
                        confirmPasswordController.text = value;
                        confirmPasswordController.selection =
                            TextSelection.fromPosition(
                                TextPosition(offset: value.length));
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
                  )
                ]);
              }
              //
              // /fin de la condition si c'est une connexion facebook/google/github
              //
            }
          }

          return Container(
            margin: EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 30,
            ),
            child: Column(
              children: [
                ...children,
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
                      onPressed: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        final registerForm = prefs.getString("register_form");
                        // on ajoute les infos du formulaire dans le stockage local
                        Map<String, dynamic> data = registerForm == null
                            ? {}
                            : jsonDecode(registerForm);

                        data.addAll({
                          'firstname': firstnameController.text,
                          'lastname': lastnameController.text,
                          'pseudo': pseudoController.text,
                          'email': emailController.text,
                          'birthday': dateController.text,
                          'password': passwordController.text,
                          'confirm_password': confirmPasswordController.text,
                        });

                        prefs.setString('register_form', jsonEncode(data));
                        Navigator.pushNamed(context, '/register/address');
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
