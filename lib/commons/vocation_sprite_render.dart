import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

class VocationSpriteRender {
  late String path;
  VocationSpriteRender(this.path);

  Future<dynamic> getImage(String path) async {
    Completer<ImageInfo> completer = Completer();
    var img = NetworkImage(path);
    img
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;
    return imageInfo.image;
  }

  Future<Widget> onLoad(BuildContext context) async {
    // récupération de l'image distante d'une façon qui permet de la mettre dans un Sprite
    final spriteSheet = await getImage(path);
    print(path);
    Vector2 spriteSize = Vector2(32, 32);
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
      amount: 3,
      stepTime: 0.25,
      textureSize: spriteSize,
    );

    SpriteAnimation vocationAnimation =
        SpriteAnimation.fromFrameData(spriteSheet, spriteData);

    SpriteAnimationWidget vocationAnimationWidget = SpriteAnimationWidget(
      animation: vocationAnimation,
      anchor: Anchor.center,
    );

    return vocationAnimationWidget.build(context);
  }
}
