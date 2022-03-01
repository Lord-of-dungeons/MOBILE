import 'package:bonfire/bonfire.dart';
import 'package:lordofdungeons/screens/play/play_solo_screen.dart';

class Barrel extends GameDecoration with ObjectCollision {
  Barrel(Vector2 position)
      : super.withSprite(
          sprite: Sprite.load('itens/barrel.png'),
          position: position,
          size: Vector2(tileSize, tileSize),
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(tileSize * 0.6, tileSize * 0.6),
            align: Vector2(tileSize * 0.2, 0),
          ),
        ],
      ),
    );
  }
}
