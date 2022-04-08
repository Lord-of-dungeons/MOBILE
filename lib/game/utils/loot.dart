import 'dart:math';
import '../../utils/constants.dart';
import 'package:bonfire/base/bonfire_game_interface.dart';
import 'package:bonfire/bonfire.dart';
import 'package:lordofdungeons/game/decoration/item_loot.dart';
import 'package:lordofdungeons/game/decoration/potion_life.dart';

class Loot {
  static void getLoot(
      Monsters monster, BonfireGameInterface gameRef, Vector2 position) {
    switch (monster) {
      case Monsters.PepeTheFrog:
        Random random = Random();
        int randomNumber = random.nextInt(2);
        bool canLoot = _getProbaToLootItem(0.5);
        if (canLoot == false) break;

        randomNumber == 0
            ? gameRef.add(PotionLife(position, 10))
            : gameRef.add(PotionLife(position, 10));
        break;
      case Monsters.Skeleton:
        bool canLoot = _getProbaToLootItem(0.2);
        if (canLoot == false) break;
        _getWeaponOrArmor(gameRef, position);
        break;
      default:
        break;
    }
  }

  static void _getWeaponOrArmor(
      BonfireGameInterface gameRef, Vector2 position) {
    Random random = Random();
    int randomCategory = random.nextInt(4);
    switch (randomCategory) {
      case 0:
        int randomNumber = random.nextInt(4);
        String path = "weapons/shield_" +
            (randomNumber + 1).toString(); // commence à 0 donc on ajoute +1
        _addItem(gameRef, position, path, true);
        break;
      case 1:
        int randomNumber = random.nextInt(2);
        String path = "weapons/trident_" +
            (randomNumber + 1).toString(); // commence à 0 donc on ajoute +1
        _addItem(gameRef, position, path, false);
        break;
      case 2:
        int randomNumber = random.nextInt(4);
        String path = "weapons/staff_" +
            (randomNumber + 1).toString(); // commence à 0 donc on ajoute +1
        _addItem(gameRef, position, path, false);
        break;
      case 3:
        int randomNumber = random.nextInt(4);
        String path = "weapons/sword_" +
            (randomNumber + 1).toString(); // commence à 0 donc on ajoute +1
        _addItem(gameRef, position, path, false);
        break;

      default:
        int randomNumber = random.nextInt(4);
        String path = "weapons/sword_" +
            (randomNumber + 1).toString(); // commence à 0 donc on ajoute +1
        _addItem(gameRef, position, path, false);
        break;
    }
  }

  static _addItem(BonfireGameInterface gameRef, Vector2 position, String path,
      bool shield) {
    path = path + ".png";
    // si c'est un bouclier la position n'est pas la même, l'id non plus
    if (shield == true) {
      gameRef.add(ItemLoot(position, path, Vector2(20, 140), 4));
    } else {
      gameRef.add(ItemLoot(position, path, Vector2(20, 80), 5));
    }
  }

  static bool _getProbaToLootItem(double proba) {
    Random random = Random();
    // on divise 1 par la proba en faisant l'arrondi pour avoir une proba entre 1 et x
    // exemple : 1/0.2 = 5 donc 1 chance sur 5
    int randomNumber = random.nextInt((1.0 / proba).round());
    // si le nombre est égal à 0 alors on peut loot
    return randomNumber == 0;
  }
}
