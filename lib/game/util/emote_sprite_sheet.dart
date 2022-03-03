import 'package:bonfire/bonfire.dart';

class EmoteSpriteSheet {
  static Future<SpriteAnimation> exclamation() => SpriteAnimation.load(
        'emote/emotes.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
          texturePosition: Vector2(0, 0),
        ),
      );

  static Future<SpriteAnimation> interrogation() => SpriteAnimation.load(
        'emote/emotes.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
          texturePosition: Vector2(0, 32),
        ),
      );

  static Future<SpriteAnimation> music() => SpriteAnimation.load(
        'emote/emotes.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
          texturePosition: Vector2(0, 64),
        ),
      );

  static Future<SpriteAnimation> love() => SpriteAnimation.load(
        'emote/emotes.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
          texturePosition: Vector2(0, 96),
        ),
      );

  static Future<SpriteAnimation> angry() => SpriteAnimation.load(
        'emote/emotes.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
          texturePosition: Vector2(0, 128),
        ),
      );

  static Future<SpriteAnimation> sad() => SpriteAnimation.load(
        'emote/emotes.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
          texturePosition: Vector2(0, 160),
        ),
      );

  static Future<SpriteAnimation> confused() => SpriteAnimation.load(
        'emote/emotes.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
          texturePosition: Vector2(0, 192),
        ),
      );

  static Future<SpriteAnimation> dots() => SpriteAnimation.load(
        'emote/emotes.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
          texturePosition: Vector2(0, 224),
        ),
      );

  static Future<SpriteAnimation> idea() => SpriteAnimation.load(
        'emote/emotes.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
          texturePosition: Vector2(0, 256),
        ),
      );

  static Future<SpriteAnimation> sleep() => SpriteAnimation.load(
        'emote/emotes.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
          texturePosition: Vector2(0, 288),
        ),
      );
}
