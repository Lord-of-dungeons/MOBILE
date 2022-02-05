import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/providers/user_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:flutter_switch/flutter_switch.dart';

class EditForm extends StatefulWidget {
  final Map<String, dynamic> state;
  const EditForm({Key? key, required this.state}) : super(key: key);

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  String email = "";
  String pseudo = "";
  //
  bool newsletter = true;
  bool loader = false;
  //
  final firstnameController = TextEditingController(text: "");
  final lastnameController = TextEditingController(text: "");
  final dateController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");
  final confirmPasswordController = TextEditingController(text: "");

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    email = widget.state["email"];
    pseudo = widget.state["pseudo"];
    firstnameController.text = widget.state["firstname"];
    lastnameController.text = widget.state["lastname"];
    dateController.text = widget.state["birthday"];
    newsletter = widget.state["newsletter"] == 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DelayedAnimation(
          delay: 500,
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
          delay: 500,
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
            delay: 500,
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
                    initialDate: DateTime.parse(dateController.text),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now());
                dateController.text = date?.toString().substring(0, 10) ?? "";
              },
            )),
        SizedBox(height: 15),
        DelayedAnimation(
          delay: 500,
          child: TextFormField(
            initialValue: email,
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
        Divider(
          thickness: 1,
        ),
        SizedBox(
          height: 15,
        ),
        DelayedAnimation(
            delay: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Newsletter",
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontFamily: "Montserrat",
                        fontSize: 14)),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FlutterSwitch(
                      width: 70,
                      height: 30,
                      valueFontSize: 14,
                      toggleSize: 20,
                      value: newsletter,
                      borderRadius: 30.0,
                      activeColor: color_purple,
                      padding: 5,
                      showOnOff: false,
                      onToggle: (val) {
                        setState(() {
                          newsletter = val;
                        });
                      },
                    ),
                  ],
                )
              ],
            )),
        SizedBox(height: 50),
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
                  loader
                      ? GFLoader(
                          type: GFLoaderType.ios,
                        )
                      : FaIcon(FontAwesomeIcons.edit),
                  SizedBox(width: 20),
                  Text(
                    'Sauvegarder',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Bungee"),
                  ),
                ],
              ),
              onPressed: () {
                Map<String, dynamic> body = {
                  "firstname": firstnameController.text,
                  "lastname": lastnameController.text,
                  "birthday": dateController.text,
                  "newsletter": newsletter
                };
                setState(() {
                  loader = true;
                });
                UserProvider()
                    .editProfile(context, body)
                    .then((value) => setState(() {
                          loader = false;
                        }));
              },
            ),
          ),
        ),
      ],
    );
  }
}
