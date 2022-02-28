import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

class Torch extends GameDecoration with Lighting {
  bool empty = false;
  Torch(Vector2 position, {this.empty = false})
      : super.withAnimation(
          animation: SpriteAnimation.load(
            'props/itens/torch_spritesheet.png',
            SpriteAnimationData.sequenced(
              amount: 6,
              stepTime: 0.1,
              textureSize: Vector2(16, 16),
            ),
          ),
          position: position,
          size: Vector2.all(16),
        ) {
    setupLighting(
      LightingConfig(
        radius: width * 2.5,
        blurBorder: width,
        pulseVariation: 0.1,
        color: Colors.deepOrangeAccent.withOpacity(0.2),
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    if (!empty) {
      super.render(canvas);
    }
  }
}
