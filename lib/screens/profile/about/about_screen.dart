import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/utils/constants.dart';

var appBar = AppBar(
  backgroundColor: color_brown,
);

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(25),
            child: DelayedAnimation(delay: 250, child: BodyAboutScreen())));
  }
}

class BodyAboutScreen extends StatelessWidget {
  const BodyAboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Conditions générales de vente",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.chevronCircleRight),
                color: Colors.grey[350],
                onPressed: () {},
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Conditions générales d'utilisation",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.chevronCircleRight),
                color: Colors.grey[350],
                onPressed: () {},
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Politique d'utilisation des données",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.chevronCircleRight),
                color: Colors.grey[350],
                onPressed: () {},
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Récupérer mes données",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.chevronCircleRight),
                color: Colors.grey[350],
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
