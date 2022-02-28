import 'dart:math';
import 'package:bonfire/bonfire.dart';
import 'package:flame/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lordofdungeons/game/decoration/torch.dart';
import 'package:lordofdungeons/game/player_sprite_sheet.dart';

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

  Future<void> _setLandscape() async {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    var tileSize = max(sizeScreen.height, sizeScreen.width) / 15;

    return FutureBuilder(
      future: _setLandscape(),
      builder: (context, snapchot) {
        return BonfireTiledWidget(
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
                spritePressed: Sprite.load('joystick_atack_range_selected.png'),
                size: 50,
                margin: EdgeInsets.only(bottom: 50, right: 160),
              )
            ],
          ),
          map: TiledWorldMap(
            'tile/map.json',
            forceTileSize: Size(tileSize, tileSize),
            objectsBuilder: {
              'torch': (p) => Torch(p.position),
              'torch_empty': (p) => Torch(p.position, empty: true),
            },
          ),
          player: Kinght(
            Vector2(2 * tileSize, 3 * tileSize),
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

class MyCustomDecoration extends GameDecoration with Lighting {
  MyCustomDecoration(Vector2 position)
      : super.withAnimation(
            size: Vector2(32, 32),
            position: position,
            animation: SpriteAnimation([
              SpriteAnimationFrame(
                  Sprite(
                      Images().fromCache("RF_Catacombs_v1.0/candleA_01.png")),
                  1)
            ])) {
    setupLighting(
      LightingConfig(
        radius: width * 1.5,
        color: Colors.transparent,
        // blurBorder: 20, // this is a default value
        // type: LightingType.circle, // this is a default value
        // useComponentAngle: false, // this is a default value. When true light rotate together component when change `angle` param.
      ),
    );
  }
}
