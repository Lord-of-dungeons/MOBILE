import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/commons/loader.dart';
import 'package:lordofdungeons/providers/auth_provider.dart';
import 'package:lordofdungeons/providers/user_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';

var appBar = AppBar(
  backgroundColor: color_yellow,
);

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
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
        child: DelayedAnimation(
          delay: 750,
          child: BodyFriendsScreen(),
        ),
      ),
    );
  }
}

class BodyFriendsScreen extends StatelessWidget {
  const BodyFriendsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List imageList = ['asset images here'];
    return Column(
      children: [
        DelayedAnimation(
          delay: 250,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            alignment: Alignment.center,
            child: Text(
              'Mes amis',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Bungee', fontSize: 18, color: Colors.black),
            ),
          ),
        ),
        DelayedAnimation(
          delay: 250,
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: imageList.length,
              itemBuilder: (context, index) => GFStickyHeader(
                stickyContent: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: color_blue, padding: EdgeInsets.all(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.userPlus,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Ajouter un ami',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Bungee",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
                stickyContentPosition: GFPosition.end,
                content: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: MediaQuery.of(context).size.height - 260,
                  alignment: Alignment.center,
                  child: ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 8,
                      itemBuilder: (BuildContext context, int index) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              GFCheckboxListTile(
                                title: Text(
                                  'Pseudo_cool',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "Montserrat",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subTitle: Text(
                                  'En ligne',
                                  style: TextStyle(
                                    color: color_green,
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                avatar: GFAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/gobelin.png'),
                                  backgroundColor: Colors.transparent,
                                  shape: GFAvatarShape.circle,
                                ),
                                size: 25,
                                activeBgColor: Colors.transparent,
                                activeIcon: FaIcon(
                                  FontAwesomeIcons.times,
                                  color: color_red,
                                ),
                                type: GFCheckboxType.circle,
                                onChanged: (val) {},
                                value: true,
                                inactiveIcon: null,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Divider(),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
