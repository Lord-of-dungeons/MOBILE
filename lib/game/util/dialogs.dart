import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lordofdungeons/game/player/knight.dart';
import 'package:lordofdungeons/game/util/localization/strings_location.dart';

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

  static Future<dynamic> showInventory(
      BuildContext context, Knight player) async {
    print(player.inventory);
    return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    GFAvatar(
                      backgroundImage:
                          AssetImage('assets/images/itens/potion_red.png'),
                      shape: GFAvatarShape.standard,
                      size: GFSize.LARGE,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Potion de vie',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Bungee",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'x' + player.inventory["potion"].toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: GFAvatar(
                  backgroundImage:
                      AssetImage('assets/images/itens/potion_red.png'),
                  shape: GFAvatarShape.standard,
                ),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: GFAvatar(
                  backgroundImage:
                      AssetImage('assets/images/itens/potion_red.png'),
                  shape: GFAvatarShape.standard,
                ),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: GFAvatar(
                  backgroundImage:
                      AssetImage('assets/images/itens/potion_red.png'),
                  shape: GFAvatarShape.standard,
                ),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: GFAvatar(
                  backgroundImage:
                      AssetImage('assets/images/itens/potion_red.png'),
                  shape: GFAvatarShape.standard,
                ),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: GFAvatar(
                  backgroundImage:
                      AssetImage('assets/images/itens/potion_red.png'),
                  shape: GFAvatarShape.standard,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
