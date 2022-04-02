import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

class ItemLootComponent extends InterfaceComponent {
  ItemLootComponent({
    required Vector2 position,
    required String path,
    required int id,
    required void Function(bool) onTapComponent,
  }) : super(
          id: id,
          position: position,
          size: Vector2(50, 50),
          spriteSelected: Sprite.load(path),
          spriteUnselected: Sprite.load(path),
          selectable: true,
          onTapComponent: onTapComponent,
        );

  @override
  void update(double t) {
    super.update(t);
  }

  @override
  void render(Canvas c) {
    super.render(c);
  }
}
