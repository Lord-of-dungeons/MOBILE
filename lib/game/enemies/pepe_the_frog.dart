import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:lordofdungeons/game/utils/emote_sprite_sheet.dart';
import 'package:lordofdungeons/game/utils/ennemy_sprite_sheet.dart';
import 'package:lordofdungeons/game/utils/sound.dart';
import 'package:lordofdungeons/screens/play/play_solo_screen.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:lordofdungeons/utils/functions.dart';
import 'package:lordofdungeons/game/utils/game_sprite_sheet.dart';
import 'package:lordofdungeons/game/utils/loot.dart';

class PepeTheFrog extends SimpleEnemy with ObjectCollision {
  final Vector2 initPosition;
  double attack = 25;
  double radiusVision = tileSize * 4;
  bool _isReceiveDamage = false;

  PepeTheFrog(this.initPosition)
      : super(
          animation: EnemySpriteSheet.pepeAnimations(),
          position: initPosition,
          size: Vector2.all(tileSize * 0.8),
          speed: tileSize / 0.35,
          life: 120,
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

    // Loot du monstre quand il meurt
    Loot.getLoot(Monsters.PepeTheFrog, gameRef, position);

    // on supprime le adavre du monstre
    removeFromParent();
    super.die();
  }

  void execAttack() {
    simpleAttackMelee(
      size: Vector2.all(tileSize * 0.62),
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
        radiusVision: radiusVision);
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

    // si il reçoit des dégats alors on affiche l'émote qu'une fois et on augmente son champ de vision pour qu'il se dirige vers la première personne qu'il voit
    if (_isReceiveDamage == false) {
      _showEmote();
    }
    radiusVision = tileSize * 10;
    _isReceiveDamage = true;

    super.receiveDamage(damage, id);
  }

  void _showEmote() {
    gameRef.add(
      AnimatedFollowerObject(
        animation: EmoteSpriteSheet.angry(),
        target: this,
        size: Vector2(32, 32),
        positionFromTarget: Vector2(18, -28),
      ),
    );
  }
}
