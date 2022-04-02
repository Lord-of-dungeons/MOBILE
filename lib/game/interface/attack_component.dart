import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:lordofdungeons/game/player/knight.dart';

class AttackComponent extends InterfaceComponent {
  AttackComponent(BuildContext context, Knight player)
      : super(
          id: 2,
          position: Vector2(20, 80),
          size: Vector2(50, 50),
          spriteSelected: Sprite.load('carre_noir.png'),
          spriteUnselected: Sprite.load('carre_noir.png'),
          selectable: false,
        );

  @override
  void update(double t) {
    super.update(t);
  }

  @override
  void render(Canvas c) {
    super.render(c);
  }
}
