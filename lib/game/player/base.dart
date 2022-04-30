import 'dart:convert';
import 'package:lordofdungeons/game/player/knight.dart';
import 'package:lordofdungeons/utils/writer_file.dart';

abstract class Base {
  Future<void> saveInfos(Knight player) async {
    try {
      print("save");
      String filename = player.nick.toLowerCase();
      WriterFile writeFile = WriterFile(filename: filename + ".json");
      Object obj = {
        "nick": player.nick,
        "xp": player.xp,
        "attack": player.attack,
        "bonusAttack": player.bonusAttack,
        "armor": player.armor,
        "bonusArmor": player.bonusArmor,
        "mana": player.mana,
        "bonusMana": player.bonusMana,
        "playerLife": player.life,
        "playerPosition": [player.position[0], player.position[1]],
        "isDead": player.isDead,
        "playerClassName": "knight",
      };
      await writeFile.writeFile(jsonEncode(obj));
    } catch (e) {}
  }
}
