import 'dart:math';
import 'package:bonfire/bonfire.dart';
import 'package:flame/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lordofdungeons/game/decoration/spike.dart';
import 'package:lordofdungeons/game/decoration/torch.dart';
import 'package:lordofdungeons/game/player/knight.dart';
import 'package:lordofdungeons/game/player_sprite_sheet.dart';

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
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
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
                )
              ],
            ),
            map: TiledWorldMap(
              'tiled/map.json',
              forceTileSize: Size(tileSize, tileSize),
              objectsBuilder: {
                'torch': (p) => Torch(p.position),
                'spikes': (p) => Spikes(p.position),
                'torch_empty': (p) => Torch(p.position, empty: true),
              },
            ),
            player: Knight(
              Vector2(2 * tileSize, 3 * tileSize),
            ),
            lightingColorGame: Colors.black.withOpacity(0.6),
            background: BackgroundColorGame(Colors.grey[900]!),
          ),
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
    // TODO: implement updateGame
  }
}
