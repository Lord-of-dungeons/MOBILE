import 'dart:convert';
import 'dart:math';
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lordofdungeons/game/decoration/spike.dart';
import 'package:lordofdungeons/game/decoration/torch.dart';
import 'package:lordofdungeons/game/enemies/pepe_the_frog.dart';
import 'package:lordofdungeons/game/enemies/skeleton.dart';
import 'package:lordofdungeons/game/enemies/vampyrus_alchemist.dart';
import 'package:lordofdungeons/game/enemies/vampyrus_boss.dart';
import 'package:lordofdungeons/game/enemies/vampyrus_guard.dart';
import 'package:lordofdungeons/game/interface/knight_interface.dart';
import 'package:lordofdungeons/game/player/knight.dart';
import 'package:lordofdungeons/game/utils/dialogs.dart';
import 'package:lordofdungeons/game/utils/sound.dart';
import 'package:lordofdungeons/utils/writer_file.dart';

double tileSize = 32;

class PlaySoloScreen extends StatefulWidget {
  const PlaySoloScreen({Key? key}) : super(key: key);

  @override
  _PlaySoloScreenState createState() => _PlaySoloScreenState();
}

class _PlaySoloScreenState extends State<PlaySoloScreen>
    with WidgetsBindingObserver
    implements GameListener {
  bool showGameOver = false;
  late GameController _controller;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    _controller = GameController()..addListener(this);
    Sounds.playBackgroundSound();
    super.initState();
  }

  Future<Map<String, dynamic>?> _getPlayerFileInfos() async {
    try {
      WriterFile writeFile = WriterFile(filename: "macron.json");

      final content = await writeFile.readFile();
      return jsonDecode(content);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        Sounds.resumeBackgroundSound();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        Sounds.pauseBackgroundSound();
        break;
      case AppLifecycleState.detached:
        Sounds.stopBackgroundSound();
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    Sounds.stopBackgroundSound();
    Sounds.dispose();
    FollowerWidget.removeAll();
    super.dispose();
  }

  Future<void> _setLandscape(BuildContext context) async {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }

  Future<Map<String, dynamic>?> _load(BuildContext context) async {
    final infos = await _getPlayerFileInfos();
    await _setLandscape(context);

    return infos;
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    var tileSize = max(sizeScreen.height, sizeScreen.width) / 15;

    return FutureBuilder(
      future: _load(context),
      builder: (context, snapchot) {
        if (snapchot.hasData == false) {
          return Material(
            color: Colors.transparent,
          );
        }

        // si y'a une erreur ou la variable vaut null car une erreur a été prise par le catch
        if (snapchot.hasError || snapchot.data == null) {
          print("error : ${snapchot.error}");
          //TODO: rediriger ou afficher erreur
          return Material(
            color: Colors.transparent,
          );
        }

        final data = snapchot.data as Map<String, dynamic>;
        // on cast les valeurs dynamic en double pour éviter une erreur de typage
        List<double> position = [
          data["playerPosition"][0] ?? 64.0,
          data["playerPosition"][1] ?? 96.0
        ];

        return Material(
          color: Colors.transparent,
          child: BonfireTiledWidget(
            gameController: _controller,
            joystick: Joystick(
              keyboardConfig: KeyboardConfig(
                keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows,
                acceptedKeys: [
                  LogicalKeyboardKey.space,
                ],
              ),
              directional: JoystickDirectional(
                spriteBackgroundDirectional:
                    Sprite.load('joystick_background.png'),
                spriteKnobDirectional: Sprite.load('joystick_knob.png'),
                size: 115,
                isFixed: true,
              ),
              actions: [
                JoystickAction(
                  actionId: 0,
                  sprite: Sprite.load('joystick_atack.png'),
                  spritePressed: Sprite.load('joystick_atack_selected.png'),
                  size: 80,
                  margin: EdgeInsets.only(bottom: 50, right: 50),
                ),
                JoystickAction(
                  actionId: 1,
                  sprite: Sprite.load('joystick_atack_range.png'),
                  spritePressed:
                      Sprite.load('joystick_atack_range_selected.png'),
                  size: 50,
                  margin: EdgeInsets.only(bottom: 50, right: 160),
                ),
                JoystickAction(
                  actionId: 2,
                  sprite: Sprite.load('joystick_atom.png'),
                  spritePressed: Sprite.load('joystick_atom_selected.png'),
                  size: 50,
                  margin: EdgeInsets.only(bottom: 50, right: 230),
                ),
                JoystickAction(
                  actionId: 3,
                  sprite: Sprite.load('joystick_armor.png'),
                  spritePressed: Sprite.load('joystick_armor_selected.png'),
                  size: 50,
                  margin: EdgeInsets.only(bottom: 50, right: 300),
                )
              ],
            ),
            map: TiledWorldMap(
              'tiled/map.json',
              forceTileSize: Size(tileSize, tileSize),
              objectsBuilder: {
                // 'player_enter_dungeon': (p) =>
                //     PlayerEnterDungeon(p.position, empty: true),
                'torch': (p) => Torch(p.position),
                'spikes': (p) => Spikes(p.position),
                'torch_empty': (p) => Torch(p.position, empty: true),
                'pepe': (p) => PepeTheFrog(p.position),
                'skeleton': (p) => Skeleton(p.position),
                'vampyrus_guard': (p) => VampyrusGuard(p.position),
                'vampyrus_alchemist': (p) => VampyrusAlchemist(p.position),
                'vampyrus_boss': (p) => VampyrusBoss(p.position),
              },
            ),
            player: Knight(
              nick: data["nick"],
              xp: data["xp"],
              attack: data["attack"],
              armor: data["armor"],
              playerPosition: position,
              life: data["playerLife"],
              mana: data["mana"],
              bonusArmor: data["bonusArmor"],
              bonusAttack: data["bonusAttack"],
              bonusMana: data["bonusMana"],
              isDead: data["isDead"],
            ),
            // showCollisionArea: true,
            lightingColorGame: Colors.black.withOpacity(0.6),
            background: BackgroundColorGame(Colors.grey[900]!),
            interface: KnightInterface(context),
            showFPS: true,
            progress: Container(
              alignment: Alignment.center,
              color: Colors.black,
              child: Center(
                child: Text(
                  "Chargement . . .",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Bungee',
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDialogGameOver() {
    setState(() {
      showGameOver = true;
    });
    Dialogs.showGameOver(
      context,
      () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PlaySoloScreen()),
          (Route<dynamic> route) => false,
        );
      },
    );
  }

  @override
  void changeCountLiveEnemies(int count) {
    // TODO: implement changeCountLiveEnemies
  }

  @override
  void updateGame() {
    if (_controller.player != null && _controller.player?.isDead == true) {
      if (!showGameOver) {
        showGameOver = true;
        _showDialogGameOver();
      }
    }
  }
}
