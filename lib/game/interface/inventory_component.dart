import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:lordofdungeons/game/player/knight.dart';
import 'package:lordofdungeons/game/utils/dialogs.dart';

class InventoryComponent extends InterfaceComponent {
  InventoryComponent(BuildContext context, Knight player)
      : super(
            id: 2,
            position: Vector2(20, 70),
            size: Vector2(64, 64),
            spriteSelected: Sprite.load('inventory.png'),
            spriteUnselected: Sprite.load('inventory.png'),
            selectable: true,
            onTapComponent: (bool b) {
              print("yop");
              Dialogs.showMenu(context, () {});
            });

  @override
  void update(double t) {
    super.update(t);
  }

  @override
  void render(Canvas c) {
    super.render(c);
  }
}
