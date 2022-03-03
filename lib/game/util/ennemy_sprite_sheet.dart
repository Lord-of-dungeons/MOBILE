import 'package:bonfire/bonfire.dart';

//TODO: augmenter le radius de la vision quand un ennemi reçoit des dégats afin qu'il se dirige vers son agresseur pour éviter de la tuer de loin sans se faire attaquer
class EnemySpriteSheet {
  static Future<SpriteAnimation> idleRight(
          {required String path,
          required Vector2 textureSize,
          required Vector2 texturePosition,
          amont = 1,
          stepTime = 1.0}) =>
      SpriteAnimation.load(
        path,
        SpriteAnimationData.sequenced(
            amount: amont,
            stepTime: stepTime,
            textureSize: textureSize,
            texturePosition: texturePosition),
      );

  static Future<SpriteAnimation> enemyAttackEffectBottom() =>
      SpriteAnimation.load(
        'enemy/atack_effect_bottom.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> enemyAttackEffectLeft() =>
      SpriteAnimation.load(
        'enemy/atack_effect_left.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );
  static Future<SpriteAnimation> enemyAttackEffectRight() =>
      SpriteAnimation.load(
        'enemy/atack_effect_right.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );
  static Future<SpriteAnimation> enemyAttackEffectTop() => SpriteAnimation.load(
        'enemy/atack_effect_top.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

// ##################################################################
//                          PEPE THE FROG
// ##################################################################
  static SimpleDirectionAnimation pepeAnimations() => SimpleDirectionAnimation(
        idleLeft: SpriteAnimation.load(
          'enemy/pepe_the_frog.png',
          SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: Vector2(127.875, 127.875),
            texturePosition: Vector2(0, 0),
          ),
        ),
        idleRight: SpriteAnimation.load(
          'enemy/pepe_the_frog.png',
          SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: Vector2(127.875, 127.875),
            texturePosition: Vector2(1406.625, 255.75),
          ),
        ),
        runLeft: SpriteAnimation.load(
          'enemy/pepe_the_frog.png',
          SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.1,
            textureSize: Vector2(127.875, 127.875),
            texturePosition: Vector2(895.125, 255.75),
          ),
        ),
        runRight: SpriteAnimation.load(
          'enemy/pepe_the_frog.png',
          SpriteAnimationData.sequenced(
              amount: 12,
              stepTime: 0.1,
              textureSize: Vector2(127.875, 127.875),
              texturePosition: Vector2(0, 383.625)),
        ),
        runDown: SpriteAnimation.load(
          'enemy/pepe_the_frog.png',
          SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.1,
            textureSize: Vector2(127.875, 127.875),
            texturePosition: Vector2(639.375, 639.375),
          ),
        ),
        runUp: SpriteAnimation.load(
          'enemy/pepe_the_frog.png',
          SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.1,
            textureSize: Vector2(127.875, 127.875),
            texturePosition: Vector2(0, 639.375),
          ),
        ),
      );

// ##################################################################
//                          SKELETON
// ##################################################################
  static SimpleDirectionAnimation skeletonAnimations() =>
      SimpleDirectionAnimation(
        idleLeft: SpriteAnimation.load(
          'enemy/skeleton.png',
          SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: Vector2(77, 77),
            texturePosition: Vector2(231, 0),
          ),
        ),
        idleRight: SpriteAnimation.load(
          'enemy/skeleton.png',
          SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: Vector2(77, 77),
            texturePosition: Vector2(0, 0),
          ),
        ),
        runLeft: SpriteAnimation.load(
          'enemy/skeleton.png',
          SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.1,
            textureSize: Vector2(77, 77),
            texturePosition: Vector2(0, 77),
          ),
        ),
        runRight: SpriteAnimation.load(
          'enemy/skeleton.png',
          SpriteAnimationData.sequenced(
              amount: 8,
              stepTime: 0.1,
              textureSize: Vector2(77, 77),
              texturePosition: Vector2(0, 144)),
        ),
        runDown: SpriteAnimation.load(
          'enemy/skeleton.png',
          SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.1,
            textureSize: Vector2(77, 77),
            texturePosition: Vector2(0, 0),
          ),
        ),
        runUp: SpriteAnimation.load(
          'enemy/skeleton.png',
          SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.1,
            textureSize: Vector2(77, 77),
            texturePosition: Vector2(0, 231),
          ),
        ),
      );

// ##################################################################
//                          VAMPYRUS GUARD
// ##################################################################
  static SimpleDirectionAnimation vampyrusGuardAnimations() =>
      SimpleDirectionAnimation(
        idleLeft: SpriteAnimation.load(
          'enemy/vampyrus_guard.png',
          SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 0),
          ),
        ),
        idleRight: SpriteAnimation.load(
          'enemy/vampyrus_guard.png',
          SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 0),
          ),
        ),
        runLeft: SpriteAnimation.load(
          'enemy/vampyrus_guard.png',
          SpriteAnimationData.sequenced(
            amount: 3,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 32),
          ),
        ),
        runRight: SpriteAnimation.load(
          'enemy/vampyrus_guard.png',
          SpriteAnimationData.sequenced(
              amount: 3,
              stepTime: 0.1,
              textureSize: Vector2(32, 32),
              texturePosition: Vector2(0, 64)),
        ),
        runDown: SpriteAnimation.load(
          'enemy/vampyrus_guard.png',
          SpriteAnimationData.sequenced(
            amount: 3,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 0),
          ),
        ),
        runUp: SpriteAnimation.load(
          'enemy/vampyrus_guard.png',
          SpriteAnimationData.sequenced(
            amount: 3,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 96),
          ),
        ),
      );

// ##################################################################
//                          VAMPYRUS ALCHEMIST
// ##################################################################
  static SimpleDirectionAnimation vampyrusAlchemistAnimations() =>
      SimpleDirectionAnimation(
        idleLeft: SpriteAnimation.load(
          'enemy/vampyrus_alchemist.png',
          SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 0),
          ),
        ),
        idleRight: SpriteAnimation.load(
          'enemy/vampyrus_alchemist.png',
          SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 0),
          ),
        ),
        runLeft: SpriteAnimation.load(
          'enemy/vampyrus_alchemist.png',
          SpriteAnimationData.sequenced(
            amount: 3,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 32),
          ),
        ),
        runRight: SpriteAnimation.load(
          'enemy/vampyrus_alchemist.png',
          SpriteAnimationData.sequenced(
              amount: 3,
              stepTime: 0.1,
              textureSize: Vector2(32, 32),
              texturePosition: Vector2(0, 64)),
        ),
        runDown: SpriteAnimation.load(
          'enemy/vampyrus_alchemist.png',
          SpriteAnimationData.sequenced(
            amount: 3,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 0),
          ),
        ),
        runUp: SpriteAnimation.load(
          'enemy/vampyrus_alchemist.png',
          SpriteAnimationData.sequenced(
            amount: 3,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 96),
          ),
        ),
      );
  static Future<SpriteAnimation> vampyrusAlchemistAttackEffectBottom() =>
      SpriteAnimation.load(
        'enemy/atack_effect_bottom.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> vampyrusAlchemistAttackEffectLeft() =>
      SpriteAnimation.load(
        'enemy/atack_effect_left.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );
  static Future<SpriteAnimation> vampyrusAlchemistAttackEffectRight() =>
      SpriteAnimation.load(
        'enemy/atack_effect_right.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );
  static Future<SpriteAnimation> vampyrusAlchemistAttackEffectTop() =>
      SpriteAnimation.load(
        'enemy/atack_effect_top.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

// ##################################################################
//                          VAMPYRUS BOSS
// ##################################################################

  static SimpleDirectionAnimation vampyrusBossAnimations() =>
      SimpleDirectionAnimation(
        idleLeft: SpriteAnimation.load(
          'enemy/vampyrus_boss.png',
          SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 0),
          ),
        ),
        idleRight: SpriteAnimation.load(
          'enemy/vampyrus_boss.png',
          SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 0),
          ),
        ),
        runLeft: SpriteAnimation.load(
          'enemy/vampyrus_boss.png',
          SpriteAnimationData.sequenced(
            amount: 3,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 32),
          ),
        ),
        runRight: SpriteAnimation.load(
          'enemy/vampyrus_boss.png',
          SpriteAnimationData.sequenced(
              amount: 3,
              stepTime: 0.1,
              textureSize: Vector2(32, 32),
              texturePosition: Vector2(0, 64)),
        ),
        runDown: SpriteAnimation.load(
          'enemy/vampyrus_boss.png',
          SpriteAnimationData.sequenced(
            amount: 3,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 0),
          ),
        ),
        runUp: SpriteAnimation.load(
          'enemy/vampyrus_boss.png',
          SpriteAnimationData.sequenced(
            amount: 3,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 96),
          ),
        ),
      );
  static Future<SpriteAnimation> vampyrusBossAttackEffectBottom() =>
      SpriteAnimation.load(
        'enemy/atack_effect_bottom.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> vampyrusBossAttackEffectLeft() =>
      SpriteAnimation.load(
        'enemy/atack_effect_left.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );
  static Future<SpriteAnimation> vampyrusBossAttackEffectRight() =>
      SpriteAnimation.load(
        'enemy/atack_effect_right.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );
  static Future<SpriteAnimation> vampyrusBossAttackEffectTop() =>
      SpriteAnimation.load(
        'enemy/atack_effect_top.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );
}
