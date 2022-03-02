import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:lordofdungeons/game/util/ennemy_sprite_sheet.dart';
import 'package:lordofdungeons/screens/play/play_solo_screen.dart';
import 'package:lordofdungeons/utils/functions.dart';

class Skeleton extends SimpleEnemy with ObjectCollision {
  final Vector2 initPosition;
  double attack = 25;

  Skeleton(this.initPosition)
      : super(
          animation: EnemySpriteSheet.skeletonAnimations(),
          position: initPosition,
          size: Vector2.all(tileSize),
          speed: tileSize / 0.30,
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
      radiusVision: tileSize * 4,
    );
  }
}
