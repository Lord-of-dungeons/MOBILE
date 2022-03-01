import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:lordofdungeons/game/player/knight.dart';
import 'package:lordofdungeons/utils/constants.dart';

class BarLifeComponent extends InterfaceComponent {
  double padding = 20;
  double widthBar = 90;
  double strokeWidth = 12;

  double maxLife = 0;
  double life = 0;
  double maxMana = 100;
  double mana = 0;

  BarLifeComponent()
      : super(
          id: 1,
          position: Vector2(20, 20),
          size: Vector2(120, 40),
          spriteSelected: Sprite.load('health_ui.png'),
          spriteUnselected: Sprite.load('health_ui.png'),
          selectable: false,
        );

  @override
  void update(double t) {
    if (gameRef.player != null) {
      life = gameRef.player!.life;
      maxLife = gameRef.player!.maxLife;
      if (gameRef.player is Knight) {
        mana = (gameRef.player as Knight).mana;
      }
    }
    super.update(t);
  }

  @override
  void render(Canvas c) {
    try {
      _drawLife(c);
      _drawMana(c);
    } catch (e) {}
    super.render(c);
  }

  void _drawLife(Canvas canvas) {
    double xBar = 48;
    double yBar = 31.5;
    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + widthBar, yBar),
        Paint()
          ..color = Colors.blueGrey[800]!
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);

    double currentBarLife = (life * widthBar) / maxLife;

    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + currentBarLife, yBar),
        Paint()
          ..color = _getColorLife(currentBarLife)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);
  }

  void _drawMana(Canvas canvas) {
    double xBar = 48;
    double yBar = 47;

    double currentBarMana = (mana * widthBar) / maxMana;

    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + currentBarMana, yBar),
        Paint()
          ..color = color_blue
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);
  }

  Color _getColorLife(double currentBarLife) {
    if (currentBarLife > widthBar - (widthBar / 3)) {
      return Colors.green;
    }
    if (currentBarLife > (widthBar / 3)) {
      return color_blue;
    } else {
      return color_red;
    }
  }
}
