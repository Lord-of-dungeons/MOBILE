import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

class CustomSpriteAnimationWidget extends StatelessWidget {
  final Future<SpriteAnimation> animation;
  final double width;
  final double height;

  const CustomSpriteAnimationWidget(
      {Key? key, required this.animation, this.width = 100, this.height = 100})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: animation.asWidget(),
    );
  }
}
