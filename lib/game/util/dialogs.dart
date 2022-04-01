import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
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

  static Future<dynamic> showInventory(
      BuildContext context, Knight player) async {
    Size screenSize = MediaQuery.of(context).size;
    print(player.inventory);
    return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      child: Text(
                        'Consommables',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Bungee",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: (screenSize.width / 2) - 40,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GFAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                  'assets/images/itens/potion_red.png'),
                              shape: GFAvatarShape.standard,
                              size: GFSize.SMALL,
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
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'x' +
                                      player.inventory["potionLife"].toString(),
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
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: (screenSize.width / 2) - 40,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GFAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                  'assets/images/itens/potion_blue.png'),
                              shape: GFAvatarShape.standard,
                              size: GFSize.SMALL,
                            ),
                            SizedBox(width: 20),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Potion de mana',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Bungee",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'x' +
                                      player.inventory["potionMana"].toString(),
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
                    ),
                  ],
                ),
                /************************************************************************************************************/
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      child: Text(
                        'Équipements',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Bungee",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: (screenSize.width / 2) - 40,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GFAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                  'assets/images/itens/potion_red.png'),
                              shape: GFAvatarShape.standard,
                              size: GFSize.SMALL,
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
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'x' +
                                      player.inventory["potionLife"].toString(),
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
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: (screenSize.width / 2) - 40,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GFAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                  'assets/images/itens/potion_blue.png'),
                              shape: GFAvatarShape.standard,
                              size: GFSize.SMALL,
                            ),
                            SizedBox(width: 20),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Potion de mana',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Bungee",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'x' +
                                      player.inventory["potionMana"].toString(),
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
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.black45,
                  child: Text(
                    "Anneau",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.black45,
                  child: Text(
                    "Cape",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.black45,
                  child: Text(
                    "Amulette",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.black45,
                  child: Text(
                    "Épée",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.black45,
                  child: Text(
                    "Bouclier",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.black45,
                  child: Text(
                    "Bottes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
