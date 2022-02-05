import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/providers/user_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';

class PseudoEditForm extends StatefulWidget {
  const PseudoEditForm({Key? key}) : super(key: key);

  @override
  _PseudoEditFormState createState() => _PseudoEditFormState();
}

class _PseudoEditFormState extends State<PseudoEditForm> {
  final pseudoController = TextEditingController(text: "");

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    pseudoController.dispose();
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
            controller: pseudoController,
            autocorrect: false,
            onChanged: (value) {
              pseudoController.text = value;
              pseudoController.selection = TextSelection.fromPosition(
                  TextPosition(offset: value.length));
            },
            decoration: InputDecoration(
              labelText: 'Nouveau pseudo',
              labelStyle: TextStyle(
                color: Colors.grey[400],
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
                  "pseudo": pseudoController.text,
                };
                UserProvider().editPseudo(context, body);
              },
            ),
          ),
        ),
      ],
    );
  }
}
