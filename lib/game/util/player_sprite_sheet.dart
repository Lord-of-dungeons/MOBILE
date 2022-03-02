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
            texturePosition: Vector2(0, 0)),
      );

  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
        "Male 01-1.png",
        SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: Vector2(32, 32),
            texturePosition: Vector2(0, 0)),
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

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight,
        idleLeft: idleLeft,
        runDown: runDown,
        runUp: runUp,
        runRight: runRight,
        runLeft: runLeft,
      );
}

class Kinght extends SimplePlayer {
  Kinght(Vector2 position)
      : super(
          position: position,
          size: Vector2(32, 32),
          animation: PlayerSpriteSheet.simpleDirectionAnimation,
        );
}
