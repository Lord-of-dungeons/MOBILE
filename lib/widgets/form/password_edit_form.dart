import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/providers/user_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';

class PasswordEditForm extends StatefulWidget {
  const PasswordEditForm({Key? key}) : super(key: key);

  @override
  _PasswordEditFormState createState() => _PasswordEditFormState();
}

class _PasswordEditFormState extends State<PasswordEditForm> {
  bool passwordObscureText = true;
  bool confirmPasswordObscureText = true;
  //
  final passwordController = TextEditingController(text: "");
  final confirmPasswordController = TextEditingController(text: "");

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
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
    return Column(
      children: [
        DelayedAnimation(
          delay: 500,
          child: TextFormField(
            controller: passwordController,
            autocorrect: false,
            obscureText: passwordObscureText,
            onChanged: (value) {
              passwordController.text = value;
              passwordController.selection = TextSelection.fromPosition(
                  TextPosition(offset: value.length));
            },
            decoration: InputDecoration(
              labelText: 'Nouveau mot de passe',
              labelStyle: TextStyle(
                color: Colors.grey[400],
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.visibility,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    passwordObscureText = !passwordObscureText;
                  });
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        DelayedAnimation(
          delay: 500,
          child: TextFormField(
            controller: confirmPasswordController,
            autocorrect: false,
            obscureText: confirmPasswordObscureText,
            onChanged: (value) {
              confirmPasswordController.text = value;
              confirmPasswordController.selection = TextSelection.fromPosition(
                  TextPosition(offset: value.length));
            },
            decoration: InputDecoration(
              labelText: 'Confirmez votre nouveau mot de passe',
              labelStyle: TextStyle(
                color: Colors.grey[400],
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.visibility,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    confirmPasswordObscureText = !confirmPasswordObscureText;
                  });
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 100),
        DelayedAnimation(
          delay: 500,
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 20,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: color_blue, padding: EdgeInsets.all(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.edit),
                  SizedBox(width: 20),
                  Text(
                    'Valider',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Bungee"),
                  ),
                ],
              ),
              onPressed: () {
                Map<String, String> body = {
                  "new_password": passwordController.text,
                  "confirm_new_password": confirmPasswordController.text,
                };
                UserProvider().editPassword(context, body);
              },
            ),
          ),
        ),
      ],
    );
  }
}
