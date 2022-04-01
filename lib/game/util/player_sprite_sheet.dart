import 'package:bonfire/bonfire.dart';

class PlayerSpriteSheet {
  static Future<SpriteAnimation> attackEffectBottom() => SpriteAnimation.load(
        'player/atack_effect_bottom.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> attackEffectLeft() => SpriteAnimation.load(
        'player/atack_effect_left.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );
  static Future<SpriteAnimation> attackEffectRight() => SpriteAnimation.load(
        'player/atack_effect_right.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );
  static Future<SpriteAnimation> attackEffectTop() => SpriteAnimation.load(
        'player/atack_effect_top.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
        "Male 01-1.png",
        SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 64)),
      );

  static Future<SpriteAnimation> get idleUp => SpriteAnimation.load(
        "Male 01-1.png",
        SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 96)),
      );

  static Future<SpriteAnimation> get idleDown => SpriteAnimation.load(
        "Male 01-1.png",
        SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 0)),
      );

  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
        "Male 01-1.png",
        SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 32)),
      );

  static Future<SpriteAnimation> get runDown => SpriteAnimation.load(
        "Male 01-1.png",
        SpriteAnimationData.sequenced(
            amount: 3,
            stepTime: 0.2,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 0)),
      );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
        "Male 01-1.png",
        SpriteAnimationData.sequenced(
            amount: 3,
            stepTime: 0.2,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 64)),
      );

  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
        "Male 01-1.png",
        SpriteAnimationData.sequenced(
            amount: 3,
            stepTime: 0.2,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 32)),
      );

  static Future<SpriteAnimation> get runUp => SpriteAnimation.load(
        "Male 01-1.png",
        SpriteAnimationData.sequenced(
            amount: 3,
            stepTime: 0.2,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 96)),
      );

  // #####################################################################
  //                              ULTI ARMOR
  // #####################################################################
  static Future<SpriteAnimation> get idleRightUltiArmor => SpriteAnimation.load(
        "spartiate.png",
        SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: Vector2(77, 77),
            texturePosition: Vector2(0, 0)),
      );

  static Future<SpriteAnimation> get idleLeftUltiArmor => SpriteAnimation.load(
        "spartiate.png",
        SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: Vector2(77, 77),
            texturePosition: Vector2(0, 0)),
      );

  static Future<SpriteAnimation> get runDownUltiArmor => SpriteAnimation.load(
        "spartiate.png",
        SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.1,
            textureSize: Vector2(77, 77),
            texturePosition: Vector2(0, 0)),
      );

  static Future<SpriteAnimation> get runRightUltiArmor => SpriteAnimation.load(
        "spartiate.png",
        SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.1,
            textureSize: Vector2(77, 77),
            texturePosition: Vector2(0, 154)),
      );

  static Future<SpriteAnimation> get runLeftUltiArmor => SpriteAnimation.load(
        "spartiate.png",
        SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.1,
            textureSize: Vector2(77, 77),
            texturePosition: Vector2(0, 77)),
      );

  static Future<SpriteAnimation> get runUpUltiArmor => SpriteAnimation.load(
        "spartiate.png",
        SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.1,
            textureSize: Vector2(77, 77),
            texturePosition: Vector2(0, 231)),
      );

  //
  //
  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight,
        idleLeft: idleLeft,
        idleDown: idleDown,
        idleUp: idleUp,
        runDown: runDown,
        runUp: runUp,
        runRight: runRight,
        runLeft: runLeft,
      );

  static SimpleDirectionAnimation get simpleDirectionAnimationUltiArmor =>
      SimpleDirectionAnimation(
        idleRight: idleRightUltiArmor,
        idleLeft: idleLeftUltiArmor,
        runDown: runDownUltiArmor,
        runUp: runUpUltiArmor,
        runRight: runRightUltiArmor,
        runLeft: runLeftUltiArmor,
      );
}
