// ignore_for_file: avoid_renaming_method_parameters
import 'dart:async' as async;
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:lordofdungeons/game/util/player_sprite_sheet.dart';
import 'package:lordofdungeons/screens/play/play_solo_screen.dart';
import 'package:lordofdungeons/utils/functions.dart';

class Knight extends SimplePlayer with Lighting, ObjectCollision {
  double initSpeed = tileSize / 0.25;
  double mana = 100;
  async.Timer? _timerMana;
  bool containKey = false;

  Knight(Vector2 position)
      : super(
          position: position,
          size: Vector2.all(tileSize),
          animation: PlayerSpriteSheet.simpleDirectionAnimation,
          speed: tileSize / 0.25,
          life: 200,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(valueByTileSize(8), valueByTileSize(8)),
            align: Vector2(
              valueByTileSize(4),
              valueByTileSize(8),
            ),
          ),
        ],
      ),
    );

    setupLighting(
      LightingConfig(
        radius: width * 1.5,
        blurBorder: width,
        color: Colors.deepOrangeAccent.withOpacity(0.2),
      ),
    );
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    speed = initSpeed * event.intensity;
    super.joystickChangeDirectional(event);
  }

  @override
  void render(Canvas c) {
    super.render(c);
  }

  @override
  void update(double dt) {
    if (isDead) return;
    _verifyMana();

    super.update(dt);
  }

  void _verifyMana() {
    if (_timerMana == null) {
      _timerMana = async.Timer(Duration(milliseconds: 500), () {
        _timerMana = null;
      });
    } else {
      return;
    }

    mana += 2;
    if (mana > 100) {
      mana = 100;
    }
  }
}
