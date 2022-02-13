import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/commons/loader.dart';
import 'package:lordofdungeons/providers/auth_provider.dart';
import 'package:lordofdungeons/providers/user_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';

var appBar = AppBar(
  backgroundColor: color_green,
);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Map<String, dynamic> state;
  //
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  void _getProfile() async {
    final data = await UserProvider().getProfile(context);
    print(data);
    if (data == false) {
      //TODO: gérer l'erreur
      setState(() {
        loaded = true;
      });
      return;
    }
    setState(() {
      state = data;
      loaded = true;
    });
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result =
        await Navigator.of(context).pushNamed("/home/profile/edit-pseudo");

    //
    // On met à jour l'affichager du pseudo dynamiquement une fois que la vaalidation faite
    //
    setState(() {
      state["pseudo"] = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar,
        body: SingleChildScrollView(
            child: loaded
                ? DelayedAnimation(
                    delay: 750,
                    child: BodyProfileScreen(
                        state: state,
                        navigateAndDisplaySelection: (context) {
                          _navigateAndDisplaySelection(context);
                        }))
                : Loader()));
  }
}

class BodyProfileScreen extends StatelessWidget {
  final dynamic state;
  final void Function(BuildContext context) navigateAndDisplaySelection;
  const BodyProfileScreen(
      {Key? key, this.state, required this.navigateAndDisplaySelection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height +
          20 -
          (appBar.preferredSize.height),
      margin: EdgeInsets.all(10),
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
                          state['pseudo'],
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Inscrit depuis le " +
                              DateFormat('dd/MM/yyyy')
                                  .format(DateTime.parse(state['dateCreate'])),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
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
                Icon(FontAwesomeIcons.userCog),
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
                    Navigator.of(context)
                        .pushNamed("/home/profile/edit", arguments: state);
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
                Icon(FontAwesomeIcons.userCircle),
                Text(
                  "Modifier mon pseudo",
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
                      navigateAndDisplaySelection(context);
                    }),
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
                Icon(FontAwesomeIcons.userShield),
                Text(
                  "Mot de passe",
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
                    Navigator.of(context)
                        .pushNamed("/home/profile/edit-password");
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
                    Navigator.of(context).pushNamed('/home/profile/about');
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
                    size: 16,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Se déconnecter',
                    style: TextStyle(
                      color: color_red,
                      fontFamily: "Bungee",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                AuthProvider().logout(context);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: color_red, padding: EdgeInsets.all(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.trash,
                    size: 16,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Supprimer mon compte',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Bungee",
                      fontSize: 12,
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
