import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/providers/character_provider.dart';
import 'package:lordofdungeons/providers/user_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';

var appBar = AppBar(
  backgroundColor: color_blue,
);

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<dynamic> characters = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    _getCharacters();
  }

  void dipose() {
    super.dispose();
  }

  void _getCharacters() async {
    final data = await CharacterProvider().getCharacters(context);
    if (data != false) {
      setState(() {
        characters = data["characters"];
        count = data["count"];
      });
    }
  }

  void _deleteCharacter(String name) async {
    final res = await UserProvider().deleteFriend(context, name);
    if (res == true) {
      // on supprime dynamiquement le personnage de la vue
      final charToRemove = characters.firstWhere(
          (element) => element["name"] == name,
          orElse: () => false);

      if (charToRemove != false) {
        characters.remove(charToRemove);
        setState(() {
          characters = characters;
          count = count - 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SingleChildScrollView(
        child: DelayedAnimation(
          delay: 750,
          child: BodyCharactersScreen(
            characters: characters,
            count: count,
            getfriends: _getCharacters,
            deleteCharacter: _deleteCharacter,
          ),
        ),
      ),
    );
  }
}

class BodyCharactersScreen extends StatelessWidget {
  final List<dynamic> characters;
  final int count;
  final void Function() getfriends;
  final void Function(String name) deleteCharacter;
  //
  const BodyCharactersScreen(
      {Key? key,
      required this.characters,
      required this.count,
      required this.getfriends,
      required this.deleteCharacter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DelayedAnimation(
          delay: 250,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            alignment: Alignment.center,
            child: Text(
              'Mes personnages',
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
              itemCount: 1,
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
                            'Nouveau personnage',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Bungee",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/home/characters/add-character');
                      }),
                ),
                stickyContentPosition: GFPosition.end,
                content: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: MediaQuery.of(context).size.height - 260,
                  alignment: Alignment.center,
                  child: ListView.builder(
                      itemCount: count,
                      itemBuilder: (BuildContext context, int index) {
                        return Listener(
                          onPointerDown: (_) {},
                          child: Column(
                            children: [
                              GFCheckboxListTile(
                                title: Text(
                                  "Test",
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
                                  backgroundImage: NetworkImage(
                                    "$url_domain${characters[index]["profilePicturePath"]}",
                                  ),
                                  backgroundColor: Colors.transparent,
                                  shape: GFAvatarShape.circle,
                                ),
                                size: 25,
                                activeBgColor: Colors.transparent,
                                activeIcon: IconButton(
                                  onPressed: () async {
                                    deleteCharacter(
                                        characters[index]["friendPseudo"]);
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.times,
                                    color: color_red,
                                  ),
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
