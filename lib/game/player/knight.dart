// ignore_for_file: avoid_renaming_method_parameters
import 'dart:async' as async;
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lordofdungeons/game/util/player_sprite_sheet.dart';
import 'package:lordofdungeons/game/util/sound.dart';
import 'package:lordofdungeons/screens/play/play_solo_screen.dart';
import 'package:lordofdungeons/utils/functions.dart';
import 'package:lordofdungeons/utils/game_sprite_sheet.dart';

class Knight extends SimplePlayer with Lighting, ObjectCollision {
  double initSpeed = tileSize / 0.25;
  double attack = 25;
  double mana = 100;
  async.Timer? _timerMana;
  async.Timer? _timerLife;
  bool containKey = false;
  bool showObserveEnemy = false;
  int regenerationLifeIncrement = 5;

  Knight(Vector2 position)
      : super(
          position: position,
          size: Vector2.all(tileSize),
          animation: PlayerSpriteSheet.simpleDirectionAnimation,
          speed: tileSize / 0.25,
          life: 200,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(valueByTileSize(8), valueByTileSize(8)),
            align: Vector2(
              valueByTileSize(4),
              valueByTileSize(8),
            ),
          ),
        ],
      ),
    );

    setupLighting(
      LightingConfig(
        radius: width * 1.5,
        blurBorder: width,
        color: Colors.deepOrangeAccent.withOpacity(0.2),
      ),
    );
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    speed = initSpeed * event.intensity;
    super.joystickChangeDirectional(event);
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (event.id == 0 && event.event == ActionEvent.DOWN) {
      actionAttack();
    }

    if (event.id == LogicalKeyboardKey.space.keyId &&
        event.event == ActionEvent.DOWN) {
      actionAttack();
    }

    if (event.id == 1 && event.event == ActionEvent.DOWN) {
      actionAttackRange();
    }
    super.joystickAction(event);
  }

  void actionAttack() {
    Sounds.attackPlayerMelee();

    simpleAttackMelee(
      damage: attack,
      animationDown: PlayerSpriteSheet.attackEffectBottom(),
      animationLeft: PlayerSpriteSheet.attackEffectLeft(),
      animationRight: PlayerSpriteSheet.attackEffectRight(),
      animationUp: PlayerSpriteSheet.attackEffectTop(),
      size: Vector2.all(tileSize),
    );
  }

  void actionAttackRange() {
    //TODO: vérifier le mana si c'est possible d'attaquer
    if (mana < 10) {
      return;
    }

    Sounds.attackRange();

    //TODO: décrémenter le mana en fonction du coût
    decrementMana(10);
    simpleAttackRange(
      animationRight: GameSpriteSheet.fireBallAttackRight(),
      animationLeft: GameSpriteSheet.fireBallAttackLeft(),
      animationUp: GameSpriteSheet.fireBallAttackTop(),
      animationDown: GameSpriteSheet.fireBallAttackBottom(),
      animationDestroy: GameSpriteSheet.fireBallExplosion(),
      size: Vector2(tileSize * 0.65, tileSize * 0.65),
      damage: 10,
      speed: initSpeed * 1.5,
      enableDiagonal: false,
      onDestroy: () {
        Sounds.explosion();
      },
      collision: CollisionConfig(
        collisions: [
          CollisionArea.rectangle(size: Vector2(tileSize / 2, tileSize / 2)),
        ],
      ),
      lightingConfig: LightingConfig(
        radius: tileSize * 0.9,
        blurBorder: tileSize / 2,
        color: Colors.deepOrangeAccent.withOpacity(0.4),
      ),
    );
  }

  void decrementMana(int i) {
    mana -= i;
    if (mana < 0) {
      mana = 0;
    }
  }

  void _verifyMana() {
    if (_timerMana == null) {
      _timerMana = async.Timer(Duration(milliseconds: 500), () {
        _timerMana = null;
      });
    } else {
      return;
    }

    mana += 2;
    if (mana > 100) {
      mana = 100;
    }
  }

  void _verifyLife() {
    if (_timerLife == null) {
      _timerLife = async.Timer(Duration(milliseconds: 1000), () {
        _timerLife = null;
        // si l'utilisateur n'est pas dans une phase de combat alors il y a une régénération incrémentielle de ses PV
        if (showObserveEnemy == false && regenerationLifeIncrement < 5) {
          regenerationLifeIncrement += 1;
        }
      });
    } else {
      return;
    }

    life += regenerationLifeIncrement;
    if (life > maxLife) {
      life = maxLife;
    }
  }

  @override
  void die() {
    removeFromParent();
    gameRef.add(
      GameDecoration.withSprite(
        sprite: Sprite.load('player/crypt.png'),
        position: Vector2(
          position.x,
          position.y,
        ),
        size: Vector2.all(30),
      ),
    );
    super.die();
  }

  @override
  void render(Canvas c) {
    super.render(c);
  }

  @override
  void update(double dt) {
    if (isDead) return;
    _verifyLife();
    _verifyMana();
    seeEnemy(
      radiusVision: tileSize * 6,
      notObserved: () {
        showObserveEnemy = false;
      },
      observed: (enemies) {
        if (showObserveEnemy) return;
        showObserveEnemy = true;
        _showEmote();
      },
    );
    super.update(dt);
  }

  @override
  void receiveDamage(double damage, dynamic id) {
    if (isDead) return;
    regenerationLifeIncrement = 1;
    showDamage(
      damage,
      config: TextStyle(
        fontSize: valueByTileSize(5),
        color: Colors.orange,
        fontFamily: 'Montserrat',
      ),
    );
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
        positionFromTarget: Vector2(18, -28),
      ),
    );
  }
}
