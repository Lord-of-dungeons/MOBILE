import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:lordofdungeons/game/util/custom_sprite_animation_widget.dart';
import 'package:lordofdungeons/game/util/ennemy_sprite_sheet.dart';
import 'package:lordofdungeons/game/util/localization/strings_location.dart';
import 'package:lordofdungeons/game/util/player_sprite_sheet.dart';
import 'package:lordofdungeons/screens/play/play_solo_screen.dart';

class PlayerEnterDungeon extends GameDecoration {
  bool empty = true;
  bool _showConversation = false;
  PlayerEnterDungeon(Vector2 position, {required this.empty})
      : super.withAnimation(
          animation: PlayerSpriteSheet.idleRight,
          position: position,
          size: Vector2(tileSize * 0.8, tileSize),
        );

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.player != null) {
      if (!_showConversation) {
        gameRef.player!.idle();
        _showConversation = true;
        _showIntroduction();
      }
    }
  }

  void _showIntroduction() {
    TalkDialog.show(
        gameRef.context,
        [
          Say(
            text: [
              TextSpan(
                text: getString('enter_dungeon_1'),
                style: TextStyle(fontFamily: "Bungee"),
              ),
            ],
            person: CustomSpriteAnimationWidget(
              animation: PlayerSpriteSheet.idleRight,
            ),
            personSayDirection: PersonSayDirection.LEFT,
          ),
          Say(
            text: [
              TextSpan(
                text: getString('enter_dungeon_2'),
                style: TextStyle(fontFamily: "Bungee"),
              ),
            ],
            person: CustomSpriteAnimationWidget(
              animation: PlayerSpriteSheet.idleRight,
            ),
            personSayDirection: PersonSayDirection.LEFT,
          ),
          Say(
            text: [
              TextSpan(
                text: getString('enter_dungeon_3'),
                style: TextStyle(
                    fontStyle: FontStyle.italic, fontFamily: "Bungee"),
              ),
            ],
            person: CustomSpriteAnimationWidget(
              animation: EnemySpriteSheet.idleRight(
                path: 'enemy/pepe_the_frog.png',
                textureSize: Vector2(127.875, 127.875),
                texturePosition: Vector2(0, 1150.875),
              ),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
          Say(
            text: [
              TextSpan(
                text: getString('enter_dungeon_4'),
                style: TextStyle(fontFamily: "Bungee"),
              ),
            ],
            person: CustomSpriteAnimationWidget(
              animation: PlayerSpriteSheet.idleRight,
            ),
            personSayDirection: PersonSayDirection.LEFT,
          ),
          Say(
            text: [
              TextSpan(
                text: getString('enter_dungeon_5'),
                style: TextStyle(
                    fontStyle: FontStyle.italic, fontFamily: "Bungee"),
              ),
            ],
            person: CustomSpriteAnimationWidget(
              animation: EnemySpriteSheet.idleRight(
                path: 'enemy/vampyrus_boss.png',
                texturePosition: Vector2(32, 0),
                textureSize: Vector2(32, 32),
              ),
            ),
            personSayDirection: PersonSayDirection.RIGHT,
          ),
        ],
        onChangeTalk: (index) {},
        onFinish: () {});
  }

  @override
  void render(Canvas canvas) {
    if (!empty) {
      super.render(canvas);
    }
  }
}
