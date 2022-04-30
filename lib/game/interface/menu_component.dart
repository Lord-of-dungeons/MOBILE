import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:lordofdungeons/game/player/knight.dart';
import 'package:lordofdungeons/game/utils/dialogs.dart';

class MenuComponent extends InterfaceComponent {
  MenuComponent(BuildContext context, Knight player)
      : super(
            id: 4,
            position: Vector2(context.size!.width.toDouble() - 52, 20),
            size: Vector2(32, 32),
            spriteSelected: Sprite.load('engrenage.png'),
            spriteUnselected: Sprite.load('engrenage.png'),
            selectable: true,
            onTapComponent: (bool b) {
              Dialogs.showMenu(context, () {
                // sauvegarde des infos
                player.saveInfos(player);
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/home",
                  (Route<dynamic> route) => false,
                );
              });
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
