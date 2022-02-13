import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/providers/character_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';

var appBar = AppBar(
  backgroundColor: color_blue,
);

class AddCharacterScreen extends StatefulWidget {
  const AddCharacterScreen({Key? key}) : super(key: key);

  @override
  _AddCharacterScreenState createState() => _AddCharacterScreenState();
}

class _AddCharacterScreenState extends State<AddCharacterScreen> {
  List<dynamic> vocations = [];
  int count = 0;
  String name = "";
  //

  @override
  void initState() {
    super.initState();
    // _getVocations();
  }

  void dipose() {
    super.dispose();
  }

  void _getVocations() async {
    final data = await CharacterProvider().getCharacters(context);
    if (data != false) {
      setState(() {
        vocations = data["vocations"];
        count = data["count"];
      });
    }
  }

  void _onChangeName(String value) {
    setState(() {
      name = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SingleChildScrollView(
        child: DelayedAnimation(
          delay: 250,
          child: BodyAddCharacterScreen(
            vocations: vocations,
            count: count,
            name: name,
            onChangeName: _onChangeName,
          ),
        ),
      ),
    );
  }
}

class BodyAddCharacterScreen extends StatelessWidget {
  final List<dynamic> vocations;
  final int count;
  final String name;
  final void Function(String value) onChangeName;
  //

  BodyAddCharacterScreen(
      {Key? key,
      required this.vocations,
      required this.count,
      required this.name,
      required this.onChangeName})
      : super(key: key);

  final CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Text(
            'Nouveau personnage',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Bungee', fontSize: 18, color: Colors.black),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          child: Text(
            'Classe',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontFamily: 'Bungee', fontSize: 14, color: Colors.black),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: CarouselSlider(
            options: CarouselOptions(height: 200),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.amber),
                      child: Text(
                        'text $i',
                        style: TextStyle(fontSize: 16.0),
                      ));
                },
              );
            }).toList(),
          ),
        ),
        // ###################################################
        // #######       Caractéristiques     ################
        // ###################################################
        Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          child: Text(
            'Caractéristiques de base',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontFamily: 'Bungee', fontSize: 14, color: Colors.black),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 50),
          alignment: Alignment.centerLeft,
          child: Text(
            '100 PV',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontFamily: 'Bungee', fontSize: 12, color: Colors.grey[350]),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 50, top: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            '200 Mana',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontFamily: 'Bungee', fontSize: 12, color: Colors.grey[350]),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 50, top: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            '50 Puissance',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontFamily: 'Bungee', fontSize: 12, color: Colors.grey[350]),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 50, top: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            '20 Dégats de base',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontFamily: 'Bungee', fontSize: 12, color: Colors.grey[350]),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Divider(
            thickness: 1,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          alignment: Alignment.center,
          child: TextFormField(
            keyboardType: TextInputType.text,
            initialValue: name,
            onChanged: onChangeName,
            decoration: InputDecoration(
              labelText: 'Donnez un nom à votre personnage',
              labelStyle: TextStyle(
                color: Colors.grey[400],
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: color_green,
                padding: EdgeInsets.all(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.dungeon,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Jouer',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Bungee",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              onPressed: name.isEmpty ? null : () {}),
        ),
      ],
    );
  }
}
