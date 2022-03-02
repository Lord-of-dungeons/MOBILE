import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:lordofdungeons/game/util/ennemy_sprite_sheet.dart';
import 'package:lordofdungeons/game/util/sound.dart';
import 'package:lordofdungeons/screens/play/play_solo_screen.dart';
import 'package:lordofdungeons/utils/functions.dart';
import 'package:lordofdungeons/utils/game_sprite_sheet.dart';

class VampyrusBoss extends SimpleEnemy with ObjectCollision {
  final Vector2 initPosition;
  double attack = 70;

  VampyrusBoss(this.initPosition)
      : super(
          animation: EnemySpriteSheet.vampyrusBossAnimations(),
          position: initPosition,
          size: Vector2.all(tileSize * 1.1),
          speed: tileSize / 0.35,
          life: 400,
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
  void die() {
    gameRef.add(
      AnimatedObjectOnce(
        animation: GameSpriteSheet.smokeExplosion(),
        position: position,
        size: Vector2(32, 32),
      ),
    );
    removeFromParent();
    super.die();
  }

  void execAttack() {
    simpleAttackMelee(
      size: Vector2.all(tileSize),
      damage: attack,
      interval: 1200,
      animationDown: EnemySpriteSheet.vampyrusBossAttackEffectBottom(),
      animationLeft: EnemySpriteSheet.vampyrusBossAttackEffectLeft(),
      animationRight: EnemySpriteSheet.vampyrusBossAttackEffectRight(),
      animationUp: EnemySpriteSheet.vampyrusBossAttackEffectTop(),
      execute: () {
        Sounds.attackEnemyMelee();
      },
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
        execAttack();
      },
      radiusVision: tileSize * 5,
    );
  }

  @override
  void receiveDamage(double damage, dynamic id) {
    showDamage(
      damage,
      config: TextStyle(
        fontSize: valueByTileSize(7),
        color: Colors.white,
        fontFamily: 'Montserrat',
      ),
    );
    super.receiveDamage(damage, id);
  }
}
