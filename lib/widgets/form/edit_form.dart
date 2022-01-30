import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditForm extends StatefulWidget {
  final Map<String, dynamic> state;
  const EditForm({Key? key, required this.state}) : super(key: key);

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final emailController = TextEditingController(text: "");
  final firstnameController = TextEditingController(text: "");
  final lastnameController = TextEditingController(text: "");
  final dateController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");
  final confirmPasswordController = TextEditingController(text: "");
  final pseudoController = TextEditingController(text: "");

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

    emailController.text = widget.state["email"];
    firstnameController.text = widget.state["firstname"];
    lastnameController.text = widget.state["lastname"];
    pseudoController.text = widget.state["pseudo"];
    dateController.text = widget.state["birthday"];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                dateController.text = date?.toString().substring(0, 10) ?? "";
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
            readOnly: true,
            showCursor: false,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(
                color: Colors.grey[400],
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
