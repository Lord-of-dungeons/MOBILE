import 'package:flutter/material.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:lordofdungeons/widgets/form/edit_form.dart';

class ProfileEditScreen extends StatefulWidget {
  final Map<String, dynamic> state;
  const ProfileEditScreen({Key? key, required this.state}) : super(key: key);

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_green,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: BodyProfileEditScreen(
        state: widget.state,
      )),
    );
  }
}

class BodyProfileEditScreen extends StatelessWidget {
  final Map<String, dynamic> state;
  const BodyProfileEditScreen({Key? key, required this.state})
      : super(key: key);

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
            delay: 500,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              alignment: Alignment.center,
              child: Text(
                'Modification du profil',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Bungee', fontSize: 18, color: Colors.black),
              ),
            ),
          ),
          // ######################################################
          //                    LOGIN FORM
          // ######################################################
          EditForm(
            state: state,
          ),
          // ######################################################
          // ######################################################
        ],
      ),
    );
  }
}
