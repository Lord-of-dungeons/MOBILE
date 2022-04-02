import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lordofdungeons/game/player/knight.dart';
import 'package:lordofdungeons/game/util/localization/strings_location.dart';
import 'package:lordofdungeons/utils/constants.dart';

class Dialogs {
  static void showGameOver(BuildContext context, VoidCallback playAgain) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/images/game_over.png',
                height: 100,
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: playAgain,
                child: Text(
                  getString('play_again'),
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Bungee',
                      fontSize: 20.0),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
