import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/providers/auth_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterAddressForm extends StatefulWidget {
  const RegisterAddressForm({Key? key}) : super(key: key);

  @override
  _RegisterAddressFormState createState() => _RegisterAddressFormState();
}

class _RegisterAddressFormState extends State<RegisterAddressForm> {
  String _city = "";
  String _zipCode = "";
  String _numAddress = "";
  String _street = "";
  String _country = "France";

  @override
  void initState() {
    super.initState();
    // on récupère l'utilisateur s'il existe dans le stockage local afin de mettre à journ l'email
    SharedPreferences.getInstance().then((value) {
      final dynamic registerForm = value.getString('register_form');
      if (registerForm == null) return;
      print(registerForm);
    });
  }

  String? numberValidator(String? value) {
    if (value == null) {
      return null;
    }
    final n = num.tryParse(value);
    if (n == null) {
      return '"$value" n\'est pas un nombre valide';
    }
    return null;
  }

  String? zipCodeValidator(String? value) {
    if (value == null) {
      return null;
    }
    final n = (value);
    if (n.length != 5) {
      return 'Format requis : 75001';
    }
    return null;
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
              initialValue: _numAddress.toString(),
              autocorrect: false,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              validator: numberValidator,
              onChanged: (value) {
                setState(() {
                  _numAddress = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'N°',
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
              initialValue: _street,
              autocorrect: false,
              onChanged: (value) {
                setState(() {
                  _street = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Rue',
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
              initialValue: _city,
              autocorrect: false,
              onChanged: (value) {
                setState(() {
                  _city = value;
                });
              },
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                labelText: 'Ville',
              ),
            ),
          ),
          SizedBox(height: 15),
          DelayedAnimation(
            delay: 1000,
            child: TextFormField(
              initialValue: _zipCode,
              autocorrect: false,
              maxLength: 5,
              validator: zipCodeValidator,
              onChanged: (value) {
                setState(() {
                  _zipCode = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Code postal',
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
              initialValue: _country,
              autocorrect: false,
              onChanged: (value) {
                setState(() {
                  _country = value;
                });
              },
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                labelText: 'Pays',
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
                child: Text('Je m\'inscris'),
                onPressed: () async {
                  final dynamic prefs = await SharedPreferences.getInstance();
                  final registerForm = prefs.getString('register_form');

                  //TODO: afficher une erreur
                  if (registerForm == null) return;

                  // formatage de l'adresse
                  var address = null;
                  // si un des champs de l'adresse est renseigné (le pays ne compte pas) alors on renseigne l'adresse
                  if (_city.isNotEmpty ||
                      _numAddress.isNotEmpty ||
                      _street.isNotEmpty ||
                      _zipCode.isNotEmpty) {
                    address = {
                      'city': _city,
                      'zip_code': _zipCode,
                      'num_address': int.parse(
                          _numAddress), // on formate en nombre pour l'api
                      'street': _street,
                      'country': _country
                    };
                  }

                  // on concataine les infos principales avec l'adresse
                  final data = {'address': address};
                  data.addAll(jsonDecode(registerForm));

                  await AuthProvider().register(context, data);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
