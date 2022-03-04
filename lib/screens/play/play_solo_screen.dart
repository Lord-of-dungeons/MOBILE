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
import 'package:lordofdungeons/game/npc/player_enter_dungeon.dart';
import 'package:lordofdungeons/game/player/knight.dart';
import 'package:lordofdungeons/game/util/dialogs.dart';
import 'package:lordofdungeons/game/util/sound.dart';

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

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    var tileSize = max(sizeScreen.height, sizeScreen.width) / 15;

    return FutureBuilder(
      future: _setLandscape(context),
      builder: (context, snapchot) {
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
                size: 100,
                isFixed: false,
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
                'player_enter_dungeon': (p) =>
                    PlayerEnterDungeon(p.position, empty: true),
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
            player: Knight(Vector2(2 * tileSize, 3 * tileSize), "Macron"),
            // showCollisionArea: true,
            lightingColorGame: Colors.black.withOpacity(0.6),
            background: BackgroundColorGame(Colors.grey[900]!),
            interface: KnightInterface(),
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
