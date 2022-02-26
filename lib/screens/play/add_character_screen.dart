import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/commons/loader.dart';
import 'package:lordofdungeons/commons/vocation_sprite_render.dart';
import 'package:lordofdungeons/providers/character_provider.dart';
import 'package:lordofdungeons/providers/vocation_provider.dart';
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
  dynamic activeVocation = {};
  int count = 0;
  String name = "";
  //

  @override
  void initState() {
    super.initState();
    _getVocations();
  }

  void dipose() {
    super.dispose();
  }

  void _getVocations() async {
    final data = await VocationProvider().getVocations(context);
    if (data != false) {
      setState(() {
        vocations = data["vocations"];
        count = data["count"];
        activeVocation = data["vocations"][0];
      });
    }
  }

  void _setActiveVocation(int index) {
    setState(() {
      activeVocation = vocations[index];
    });
  }

  dynamic _getActiveVocation() {
    return activeVocation;
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
          child: vocations.isEmpty
              ? Loader()
              : BodyAddCharacterScreen(
                  vocations: vocations,
                  count: count,
                  name: name,
                  onChangeName: _onChangeName,
                  setActiveVocation: _setActiveVocation,
                  getActiveVocation: _getActiveVocation),
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
  final void Function(int index) setActiveVocation;
  final dynamic Function() getActiveVocation;
  //

  const BodyAddCharacterScreen({
    Key? key,
    required this.vocations,
    required this.count,
    required this.name,
    required this.onChangeName,
    required this.setActiveVocation,
    required this.getActiveVocation,
  }) : super(key: key);

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
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider.builder(
              itemCount: count,
              options: CarouselOptions(
                enableInfiniteScroll: true,
                height: MediaQuery.of(context).size.height - 200,
                viewportFraction: 1,
                initialPage: 0,
                onPageChanged: (i, reason) => setActiveVocation(i),
              ),
              itemBuilder: (BuildContext context, int itemIndex,
                      int pageViewIndex) =>
                  FutureBuilder(
                      future: VocationSpriteRender(
                              "$url_api/public/vocation/${vocations[itemIndex]['idVocation']}/${vocations[itemIndex]['vocationAppearance']['imgPath']}")
                          .onLoad(context),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  vocations[itemIndex]["name"],
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: 'Bungee',
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/dungeon_home.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 15.0),
                                padding: EdgeInsets.all(30),
                                child: snapshot.data as Widget,
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
                                      fontFamily: 'Bungee',
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 50),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${vocations[itemIndex]["baseFeature"]["health"]} PV',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: 'Bungee',
                                      fontSize: 12,
                                      color: Colors.grey[500]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 50, top: 20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${vocations[itemIndex]["baseFeature"]["mana"]} mana',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: 'Bungee',
                                      fontSize: 12,
                                      color: Colors.grey[500]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 50, top: 20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${vocations[itemIndex]["baseFeature"]["armor"]} armure',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: 'Bungee',
                                      fontSize: 12,
                                      color: Colors.grey[500]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 50, top: 20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${vocations[itemIndex]["baseFeature"]["attack"]} dégats de base',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: 'Bungee',
                                      fontSize: 12,
                                      color: Colors.grey[500]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 50, top: 20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${vocations[itemIndex]["baseFeature"]["attackSpeed"]} de vitesse d\'attaque',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: 'Bungee',
                                      fontSize: 12,
                                      color: Colors.grey[500]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 50, top: 20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${vocations[itemIndex]["baseFeature"]["attack"]}% en coup critique',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: 'Bungee',
                                      fontSize: 12,
                                      color: Colors.grey[500]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 50, top: 20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${vocations[itemIndex]["baseFeature"]["wisdom"]}% en fuite',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: 'Bungee',
                                      fontSize: 12,
                                      color: Colors.grey[500]),
                                ),
                              ),
                            ],
                          );
                        }

                        return Container();
                      }),
            )),
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
              onPressed: name.isEmpty
                  ? null
                  : () {
                      CharacterProvider().addCharacter(
                          context, name, getActiveVocation()["idVocation"]);
                    }),
        ),
      ],
    );
  }
}


// class MyGame extends FlameGame {
//   late String path;
//   MyGame(this.path);

//   Future<dynamic> getImage(String path) async {
//     Completer<ImageInfo> completer = Completer();
//     var img = NetworkImage(path);
//     img
//         .resolve(ImageConfiguration())
//         .addListener(ImageStreamListener((ImageInfo info, bool _) {
//       completer.complete(info);
//     }));
//     ImageInfo imageInfo = await completer.future;
//     return imageInfo.image;
//   }

//   @override
//   // ignore: must_call_super
//   Future<void> onLoad() async {
//     // récupération de l'image distante d'une façon qui permet de la mettre dans un Sprite
//     final spriteSheet = await getImage(path);
//     print("path : $path");
//     final spriteSize = Vector2(100, 90);
//     SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
//         amount: 3, stepTime: 0.25, textureSize: Vector2(32, 32));

//     SpriteComponent background = SpriteComponent()
//       ..sprite = await loadSprite("dungeon_home.png")
//       ..size = size;

//     // ajout du fond
//     add(background);

//     SpriteAnimationComponent vocationAnimation =
//         SpriteAnimationComponent.fromFrameData(spriteSheet, spriteData)
//           ..x = size.x / 3
//           ..y = size.y / 2.5
//           ..size = spriteSize;

//     // ajout du perso
//     add(vocationAnimation);
//   }
// }
