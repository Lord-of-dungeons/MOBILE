import 'package:bonfire/bonfire.dart';
import 'package:lordofdungeons/game/player/knight.dart';
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

  void _addLifeToInventory() {
    Knight? player = gameRef.player as Knight?;
    if (player is! Knight) return;

    // incrémentation des potions dans l'inventaire
    player.inventory.update("potion", (v) => v + 1);
  }

  @override
  void onContact(GameComponent collision) {
    if (collision is Player) {
      _addLifeToInventory();
      removeFromParent();
    }
  }
}
