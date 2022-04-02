import 'package:bonfire/bonfire.dart';
import 'package:lordofdungeons/game/interface/item_component.dart';
import 'package:lordofdungeons/game/player/knight.dart';
import 'package:lordofdungeons/screens/play/play_solo_screen.dart';

class ItemAttack extends GameDecoration with Sensor {
  final Vector2 initPosition;

  ItemAttack(this.initPosition, String path)
      : super.withSprite(
          sprite: Sprite.load(path),
          position: initPosition,
          size: Vector2(tileSize, tileSize),
        );

  void _add() {
    GameInterface? interface = gameRef.interface;
    Knight? player = gameRef.player as Knight?;
    if (player is! Knight) return;
    if (interface is! GameInterface) return;

    interface.add(ItemComponent(
      onTapComponent: (p) => {interface.removeById(4)},
      id: 4,
      path: "weapons/sword_1.png",
      position: Vector2(20, 140),
    ));
  }

  @override
  void onContact(GameComponent collision) {
    if (collision is Player) {
      _add();
      removeFromParent();
    }
  }
}
