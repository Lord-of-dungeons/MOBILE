import 'package:flutter/material.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/providers/auth_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:lordofdungeons/widgets/form/register_address_form.dart';

class RegisterAddressScreen extends StatefulWidget {
  const RegisterAddressScreen({Key? key}) : super(key: key);

  @override
  _RegisterAddressScreenState createState() => _RegisterAddressScreenState();
}

class _RegisterAddressScreenState extends State<RegisterAddressScreen> {
  @override
  void initState() {
    super.initState();
    AuthProvider().autoLogIn(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
        backgroundColor: color_green,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: BodyRegisterAddressScreen()),
    );
  }
}

class BodyRegisterAddressScreen extends StatelessWidget {
  const BodyRegisterAddressScreen({Key? key}) : super(key: key);

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
            delay: 250,
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/troll.png",
                width: 200,
              ),
            ),
          ),
          DelayedAnimation(
            delay: 500,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Informations complémentaires (non obligatoires)',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Bungee', fontSize: 18, color: Colors.black),
              ),
            ),
          ),
          // ######################################################
          //                    LOGIN FORM
          // ######################################################
          RegisterAddressForm(),
          // ######################################################
          // ######################################################
        ],
      ),
    );
  }
}
