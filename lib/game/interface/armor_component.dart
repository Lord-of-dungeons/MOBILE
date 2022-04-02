import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:lordofdungeons/game/player/knight.dart';

class ArmorComponent extends InterfaceComponent {
  ArmorComponent(BuildContext context, Knight player)
      : super(
          id: 3,
          position: Vector2(20, 140),
          size: Vector2(50, 50),
          spriteSelected: Sprite.load('carre_noir.png'),
          spriteUnselected: Sprite.load('carre_noir.png'),
          selectable: true,
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
