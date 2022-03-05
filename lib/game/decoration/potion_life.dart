import 'package:bonfire/bonfire.dart';
import 'package:lordofdungeons/screens/play/play_solo_screen.dart';

class PotionLife extends GameDecoration with Sensor {
  final Vector2 initPosition;
  final double life;

  PotionLife(this.initPosition, this.life)
      : super.withSprite(
          sprite: Sprite.load('itens/potion_red.png'),
          position: initPosition,
          size: Vector2(tileSize, tileSize),
        );

  void _starTimeAddLife() {
    gameRef.player?.addLife(life);
  }

  @override
  void onContact(GameComponent collision) {
    if (collision is Player) {
      _starTimeAddLife();
      removeFromParent();
    }
  }
}
