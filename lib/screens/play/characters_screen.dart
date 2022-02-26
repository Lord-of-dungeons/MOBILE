import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/commons/vocation_sprite_render.dart';
import 'package:lordofdungeons/providers/character_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:lordofdungeons/utils/xp.dart';

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

  Future<void> _deleteCharacter(BuildContext context, int idCharacter) async {
    final res = await CharacterProvider().deleteCharacter(context, idCharacter);
    if (res == true) {
      // on supprime dynamiquement le personnage de la vue
      final charToRemove = characters.firstWhere(
          (element) => element["idCharacter"] == idCharacter,
          orElse: () => false);

      if (charToRemove != false) {
        characters.remove(charToRemove);
        setState(() {
          characters = characters;
          count = count - 1;
        });

        // fermeture de la modal
        Navigator.of(context).pop();
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
            getCharacters: _getCharacters,
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
  final void Function() getCharacters;
  final Future<void> Function(BuildContext context, int idCharacter)
      deleteCharacter;
  //
  const BodyCharactersScreen(
      {Key? key,
      required this.characters,
      required this.count,
      required this.getCharacters,
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
                      onPressed: () async {
                        final res = await Navigator.of(context)
                            .pushNamed('/home/characters/add-character');

                        if (res == true) {
                          getCharacters();
                        }
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
                          child: FutureBuilder(
                              future: VocationSpriteRender(
                                      "$url_api/public/vocation/${characters[index]["vocation"]['idVocation']}/${characters[index]["vocation"]['vocationAppearance']['imgPath']}")
                                  .onLoad(context),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GFCheckboxListTile(
                                        title: Text(
                                          characters[index]["name"],
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: "Bungee",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        subTitle: Text(
                                          "${characters[index]["vocation"]["name"]} Niveau ${Xp(characters[index]["xp"]).getLevel()}",
                                          style: TextStyle(
                                            color: Colors.grey[500],
                                            fontFamily: "Bungee",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        avatar: Container(
                                          margin: EdgeInsets.only(right: 15),
                                          height: 75,
                                          width: 75,
                                          child: snapshot.data as Widget,
                                        ),
                                        activeBgColor: Colors.transparent,
                                        activeIcon: IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      'Alerte',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: "Bungee",
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ), // To display the title it is optional
                                                    content: Text(
                                                      'Voulez-vous vraiment supprimer le personnage ${characters[index]["name"]} ?',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(),
                                                        child: Text(
                                                          'ANNULER',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          deleteCharacter(
                                                              context,
                                                              characters[index][
                                                                  "idCharacter"]);
                                                        },
                                                        child: Text(
                                                          'SUPPRIMER',
                                                          style: TextStyle(
                                                            color: color_red,
                                                            fontFamily:
                                                                "Montserrat",
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                });
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
                                  );
                                }

                                return Container();
                              }),
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
