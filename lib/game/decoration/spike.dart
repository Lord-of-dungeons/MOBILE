import 'package:bonfire/bonfire.dart';
import 'package:lordofdungeons/screens/play/play_solo_screen.dart';
import 'package:lordofdungeons/game/utils/game_sprite_sheet.dart';

class Spikes extends GameDecoration with Sensor {
  final double damage;

  Spikes(Vector2 position, {this.damage = 60})
      : super.withAnimation(
          animation: GameSpriteSheet.spikes(),
          position: position,
          size: Vector2(tileSize, tileSize),
        ) {
    setupSensorArea(
      // align: Vector2(valueByTileSize(2), valueByTileSize(4)),
      // size: Vector2(valueByTileSize(14), valueByTileSize(12)),
      intervalCheck: 100,
    );
  }

  @override
  // ignore: avoid_renaming_method_parameters
  void onContact(GameComponent collision) {
    if (collision is Player) {
      if (animation?.currentIndex == (animation?.frames.length ?? 0) - 1 ||
          animation?.currentIndex == (animation?.frames.length ?? 0) - 2) {
        gameRef.player?.receiveDamage(damage, 0);
      }
    }
  }

  @override
  int get priority => LayerPriority.getComponentPriority(1);
}
