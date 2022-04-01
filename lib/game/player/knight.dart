// ignore_for_file: avoid_renaming_method_parameters
import 'dart:async' as async;
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lordofdungeons/game/util/custom_sprite_animation_widget.dart';
import 'package:lordofdungeons/game/util/player_sprite_sheet.dart';
import 'package:lordofdungeons/game/util/sound.dart';
import 'package:lordofdungeons/screens/play/play_solo_screen.dart';
import 'package:lordofdungeons/utils/functions.dart';
import 'package:lordofdungeons/utils/game_sprite_sheet.dart';

class Knight extends SimplePlayer with Lighting, ObjectCollision {
  double initSpeed = tileSize / 0.25;
  double attack = 25;
  double mana = 100;
  bool containKey = false;
  bool showObserveEnemy = false;
  int regenerationLifeIncrement = 5;
  int ultiArmorCounter = 0;
  //
  async.Timer? _timerMana;
  async.Timer? _timerLife;
  async.Timer? _timerPulse;
  async.Timer? _ultiArmorCounter;
  //
  final String nick;
  Vector2 sizeTextNick = Vector2.zero();
  late TextPaint _textConfigNick;

  Knight(Vector2 position, this.nick)
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

    // setup du nom du perso flotant au dessus de lui
    _textConfigNick = TextPaint(
      style: TextStyle(
        fontSize: tileSize / 3,
        fontFamily: "Montserrat",
        color: Colors.white,
      ),
    );
    sizeTextNick = _textConfigNick.measureText(nick);
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    speed = initSpeed * event.intensity;
    super.joystickChangeDirectional(event);
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    // attaque de base
    if (event.id == 0 && event.event == ActionEvent.DOWN) {
      actionAttack();
    }

    if (event.id == LogicalKeyboardKey.space.keyId &&
        event.event == ActionEvent.DOWN) {
      actionAttack();
    }

    // sort
    if (event.id == 1 && event.event == ActionEvent.DOWN) {
      actionAttackRange();
    }

    // ulti mage
    if (event.id == 2 && event.event == ActionEvent.DOWN) {
      actionUltimateRange();
    }

    // ulti guerrier
    if (event.id == 3 &&
        event.event == ActionEvent.DOWN &&
        ultiArmorCounter == 0) {
      actionUltimateArmor();
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

  void actionUltimateRange() {
    //TODO: vérifier le mana si c'est possible d'attaquer
    if (mana < 40) {
      return;
    }

    Sounds.attackRange();

    //TODO: décrémenter le mana en fonction du coût
    decrementMana(40);

    Sounds.thunder();
    // salve de boules électriques de 33*5 dégats
    for (var i = 0; i < 5; i++) {
      _timerPulse = async.Timer(Duration(milliseconds: i * 400), () {
        simpleAttackRange(
          animationRight: GameSpriteSheet.pulseAttackRight(),
          animationLeft: GameSpriteSheet.pulseAttackLeft(),
          animationUp: GameSpriteSheet.pulseAttackTop(),
          animationDown: GameSpriteSheet.pulseAttackBottom(),
          animationDestroy: GameSpriteSheet.pulseExplosion(),
          size: Vector2(tileSize * 1.5, tileSize * 1.5),
          damage: 33,
          speed: initSpeed * 1.5,
          enableDiagonal: false,
          onDestroy: () {
            Sounds.explosion();
          },
          collision: CollisionConfig(
            collisions: [
              CollisionArea.rectangle(
                  size: Vector2(tileSize / 1.5, tileSize / 1.5)),
            ],
          ),
          lightingConfig: LightingConfig(
            radius: tileSize,
            blurBorder: tileSize / 2,
            color: Color.fromARGB(255, 128, 217, 233).withOpacity(0.4),
          ),
        );
      });
      // destruction du timer
      _timerPulse = null;
    }
  }

  void actionUltimateArmor() {
    //TODO: vérifier le mana si c'est possible d'attaquer
    if (mana < 40) {
      return;
    }

    //TODO: décrémenter le mana en fonction du coût
    decrementMana(40);

    Sounds.bioup();
    FollowerWidget.show(
      identify: 'ULTI_ARMOR', // identify used to remove
      context: context,
      target: this, // You can add here any GameComponent
      child: CustomSpriteAnimationWidget(
        animation: SpriteAnimation.load(
          "shield_20.png",
          SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: Vector2(24, 24),
          ),
        ),
        width: 25,
        height: 25,
      ),
      align: Offset(2.5, -45),
    );
    for (var i = 0; i <= 10; i++) {
      _ultiArmorCounter = async.Timer(Duration(seconds: i), () {
        ultiArmorCounter = 10 - i;

        // on émet un son quand le bouclier arrive à expiration
        if (ultiArmorCounter < 4 && ultiArmorCounter > 0) {
          Sounds.countHide();
        }

        // suppression de l'ulti
        if (ultiArmorCounter == 0) {
          Sounds.bioup();
          FollowerWidget.remove("ULTI_ARMOR");
        }
      });
    }
    _ultiArmorCounter = null;
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
    FollowerWidget.remove("ULTI_ARMOR");
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
    _renderNickName(c);

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
    Color color = Colors.orange;

    // si l'ulti armor est activé alors on réduit par 2 les dégats
    if (ultiArmorCounter > 0) {
      damage = (damage / 2).ceilToDouble();
      color = Colors.orangeAccent;
    }

    showDamage(
      damage,
      config: TextStyle(
        fontSize: valueByTileSize(5),
        color: color,
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

  void _renderNickName(Canvas canvas) {
    _textConfigNick.render(
      canvas,
      nick,
      Vector2(
        position.x + ((width - sizeTextNick.x) / 2),
        position.y - sizeTextNick.y - 3,
      ),
    );
  }
}
