import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/commons/loader.dart';
import 'package:lordofdungeons/providers/user_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: color_green,
        ),
        body: SingleChildScrollView(
          child: DelayedAnimation(
            delay: 750,
            child: FutureBuilder(
              future: UserProvider().getProfile(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return BodyProfileScreen(
                    state: snapshot.data,
                  );
                }

                return Loader();
              },
            ),
          ),
        ));
  }
}

class BodyProfileScreen extends StatelessWidget {
  final dynamic state;
  const BodyProfileScreen({Key? key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height - 100,
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                      "$url_domain${state['profilePicturePath']}",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state['firstname'],
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          state['lastname'],
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: Colors.grey[600]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              VerticalDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Inscrit depuis le",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy')
                        .format(DateTime.parse(state['dateCreate'])),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: 100,
            ),
            padding: EdgeInsets.only(right: 25, left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.userAlt),
                Text(
                  "Modifier mon profil",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Bungee',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[350],
                    shadowColor: Colors.grey[350],
                    elevation: 5,
                  ),
                  child: Icon(
                    FontAwesomeIcons.chevronRight,
                    size: 20,
                  ),
                  onPressed: () {
                    print("");
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 25,
            ),
            padding: EdgeInsets.only(right: 25, left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.chartArea),
                Text(
                  "Statistiques",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Bungee',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[350],
                    shadowColor: Colors.grey[350],
                    elevation: 5,
                  ),
                  child: Icon(
                    FontAwesomeIcons.chevronRight,
                    size: 20,
                  ),
                  onPressed: () {
                    print("");
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 25,
            ),
            padding: EdgeInsets.only(right: 25, left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.infoCircle),
                Text(
                  "À propos",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Bungee',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[350],
                    shadowColor: Colors.grey[350],
                    elevation: 5,
                  ),
                  child: Icon(
                    FontAwesomeIcons.chevronRight,
                    size: 20,
                  ),
                  onPressed: () {
                    print("");
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 100,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey[300], padding: EdgeInsets.all(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.signOutAlt,
                    color: color_red,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Se déconnecter',
                    style: TextStyle(
                      color: color_red,
                      fontFamily: "Bungee",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 25,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: color_red, padding: EdgeInsets.all(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.trash),
                  SizedBox(width: 20),
                  Text(
                    'Supprimer mon compte',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Bungee",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
