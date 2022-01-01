import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/utils/constants.dart';

class RegisterAddressForm extends StatefulWidget {
  const RegisterAddressForm({Key? key}) : super(key: key);

  @override
  _RegisterAddressFormState createState() => _RegisterAddressFormState();
}

class _RegisterAddressFormState extends State<RegisterAddressForm> {
  var _city = "";
  var _zipCode = "";
  var _numAddress = "";
  var _street = "";
  var _country = "France";

  @override
  void initState() {
    super.initState();
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
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
