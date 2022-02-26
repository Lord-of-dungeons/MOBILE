import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

class UltimateSpriteRender {
  late String path;
  late Vector2 spriteSize;
  late int amount;
  UltimateSpriteRender(this.path, this.spriteSize, this.amount);

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
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
      amount: amount,
      stepTime: 0.33,
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
