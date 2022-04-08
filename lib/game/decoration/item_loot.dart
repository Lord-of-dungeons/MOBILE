import 'package:bonfire/bonfire.dart';
import 'package:lordofdungeons/game/interface/item_loot_component.dart';
import 'package:lordofdungeons/game/player/knight.dart';
import 'package:lordofdungeons/screens/play/play_solo_screen.dart';

class ItemLoot extends GameDecoration with Sensor {
  final Vector2 initPosition;
  final String path;
  final Vector2 positionInterface;
  final int id;

  ItemLoot(this.initPosition, this.path, this.positionInterface, this.id)
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

    // on supprime l'ancien item
    interface.removeById(id);

    // on ajoute le nouvel item
    interface.add(ItemLootComponent(
      onTapComponent: (p) {
        interface.removeById(id);
        // on met à jour les stats en supprimant ceux des anciens items
        _calculateBonus(player, id, false);
      },
      id: id,
      path: path,
      position: positionInterface,
    ));

    // on met à jour les stats
    _calculateBonus(player, id, true);
  }

  void _calculateBonus(Knight player, int id, bool add) {
    switch (id) {
      case 4:
        // si on supprime l'objet alors on supprime le bonus
        double bonus = add ? 10 : 0;
        player.bonusArmor = bonus;
        break;
      case 5:
        // si on supprime l'objet alors on supprime le bonus
        double bonus = add ? 10 : 0;
        player.bonusAttack = bonus;
        break;
      default:
    }
  }

  @override
  void onContact(GameComponent collision) {
    if (collision is Player) {
      _add();
      removeFromParent();
    }
  }
}
