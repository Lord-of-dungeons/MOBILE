import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:lordofdungeons/game/util/ennemy_sprite_sheet.dart';
import 'package:lordofdungeons/screens/play/play_solo_screen.dart';
import 'package:lordofdungeons/utils/functions.dart';

class VampyrusGuard extends SimpleEnemy with ObjectCollision {
  final Vector2 initPosition;
  double attack = 25;

  VampyrusGuard(this.initPosition)
      : super(
          animation: EnemySpriteSheet.vampyrusGuardAnimations(),
          position: initPosition,
          size: Vector2.all(tileSize * 0.9),
          speed: tileSize / 0.33,
          life: 200,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(
              valueByTileSize(7),
              valueByTileSize(7),
            ),
            align: Vector2(valueByTileSize(3), valueByTileSize(4)),
          ),
        ],
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    drawDefaultLifeBar(
      canvas,
      borderRadius: BorderRadius.circular(2),
    );
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);

    seeAndMoveToPlayer(
      closePlayer: (player) {
        // execAttack();
      },
      radiusVision: tileSize * 5,
    );
  }
}
