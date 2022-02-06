import 'package:flutter/material.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:lordofdungeons/widgets/form/pseudo_edit_form.dart';

var appBar = AppBar(
  backgroundColor: color_purple,
);

class PseudoEditScreen extends StatelessWidget {
  const PseudoEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: BodyPseudoEditScreen()),
    );
  }
}

class BodyPseudoEditScreen extends StatelessWidget {
  const BodyPseudoEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height -
          (MediaQuery.of(context).padding.top + appBar.preferredSize.height),
      margin: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      child: Column(
        children: [
          DelayedAnimation(
            delay: 250,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              alignment: Alignment.center,
              child: Text(
                'Modification du pseudo',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Bungee', fontSize: 18, color: Colors.black),
              ),
            ),
          ),
          // ######################################################
          //                    FORM
          // ######################################################
          PseudoEditForm(),
          // ######################################################
          // ######################################################
        ],
      ),
    );
  }
}
