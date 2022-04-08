import 'package:bonfire/bonfire.dart';

class GameSpriteSheet {
  static Future<SpriteAnimation> openTheDoor() => SpriteAnimation.load(
        'itens/door_open.png',
        SpriteAnimationData.sequenced(
          amount: 14,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
        ),
      );
  static Future<SpriteAnimation> spikes() => SpriteAnimation.load(
        'itens/spikes.png',
        SpriteAnimationData.sequenced(
          amount: 10,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );
  static Future<SpriteAnimation> torch() => SpriteAnimation.load(
        'itens/torch_spritesheet.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> explosion() => SpriteAnimation.load(
        'explosion.png',
        SpriteAnimationData.sequenced(
          amount: 7,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
        ),
      );

  static Future<SpriteAnimation> smokeExplosion() => SpriteAnimation.load(
        'smoke_explosin.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  // ###########################################################
  //                        FIREBALL
  // ###########################################################
  static Future<SpriteAnimation> fireBallAttackRight() => SpriteAnimation.load(
        'player/fireball_right.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(23, 23),
        ),
      );

  static Future<SpriteAnimation> fireBallAttackLeft() => SpriteAnimation.load(
        'player/fireball_left.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(23, 23),
        ),
      );

  static Future<SpriteAnimation> fireBallAttackTop() => SpriteAnimation.load(
        'player/fireball_top.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(23, 23),
        ),
      );

  static Future<SpriteAnimation> fireBallAttackBottom() => SpriteAnimation.load(
        'player/fireball_bottom.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(23, 23),
        ),
      );

  static Future<SpriteAnimation> fireBallExplosion() => SpriteAnimation.load(
        'player/explosion_fire.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
        ),
      );

  // ###########################################################
  //                        ULTIMATE
  // ###########################################################
  static Future<SpriteAnimation> pulseAttackRight() => SpriteAnimation.load(
        'player/pulse.png',
        SpriteAnimationData.sequenced(
          amount: 5,
          stepTime: 0.1,
          textureSize: Vector2(192, 192),
        ),
      );

  static Future<SpriteAnimation> pulseAttackLeft() => SpriteAnimation.load(
        'player/pulse.png',
        SpriteAnimationData.sequenced(
          amount: 5,
          stepTime: 0.1,
          textureSize: Vector2(192, 192),
        ),
      );

  static Future<SpriteAnimation> pulseAttackTop() => SpriteAnimation.load(
        'player/pulse.png',
        SpriteAnimationData.sequenced(
          amount: 5,
          stepTime: 0.1,
          textureSize: Vector2(192, 192),
        ),
      );

  static Future<SpriteAnimation> pulseAttackBottom() => SpriteAnimation.load(
        'player/pulse.png',
        SpriteAnimationData.sequenced(
          amount: 5,
          stepTime: 0.1,
          textureSize: Vector2(192, 192),
        ),
      );

  static Future<SpriteAnimation> pulseExplosion() => SpriteAnimation.load(
        'player/pulse.png',
        SpriteAnimationData.sequenced(
          amount: 5,
          stepTime: 0.1,
          textureSize: Vector2(192, 192),
          texturePosition: Vector2(0, 192),
        ),
      );
}
