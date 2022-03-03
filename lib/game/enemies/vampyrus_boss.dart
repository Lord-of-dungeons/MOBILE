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
  double radiusVision = tileSize * 4;
  bool _isReceiveDamage = false;

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
      radiusVision: radiusVision,
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

    // si il reçoit des dégats alors on affiche l'émote qu'une fois et on augmente son champ de vision pour qu'il se dirige vers la première personne qu'il voit
    if (_isReceiveDamage == false) {
      _showEmote();
    }
    radiusVision = tileSize * 10;
    _isReceiveDamage = true;

    super.receiveDamage(damage, id);
  }

  void _showEmote({String emote = 'emote/emote_exclamation.png'}) {
    gameRef.add(
      AnimatedFollowerObject(
        animation: SpriteAnimation.load(
          emote,
          SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
          ),
        ),
        target: this,
        size: Vector2(32, 32),
        positionFromTarget: Vector2(18, -24),
      ),
    );
  }
}
