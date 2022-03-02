import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:lordofdungeons/game/util/ennemy_sprite_sheet.dart';
import 'package:lordofdungeons/game/util/sound.dart';
import 'package:lordofdungeons/screens/play/play_solo_screen.dart';
import 'package:lordofdungeons/utils/functions.dart';
import 'package:lordofdungeons/utils/game_sprite_sheet.dart';

class VampyrusGuard extends SimpleEnemy with ObjectCollision {
  final Vector2 initPosition;
  double attack = 40;

  VampyrusGuard(this.initPosition)
      : super(
          animation: EnemySpriteSheet.vampyrusGuardAnimations(),
          position: initPosition,
          size: Vector2.all(tileSize * 0.9),
          speed: tileSize / 0.33,
          life: 150,
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
      size: Vector2.all(tileSize * 0.8),
      damage: attack,
      interval: 800,
      animationDown: EnemySpriteSheet.enemyAttackEffectBottom(),
      animationLeft: EnemySpriteSheet.enemyAttackEffectLeft(),
      animationRight: EnemySpriteSheet.enemyAttackEffectRight(),
      animationUp: EnemySpriteSheet.enemyAttackEffectTop(),
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
