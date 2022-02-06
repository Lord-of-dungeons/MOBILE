import 'package:flutter/material.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/dungeon_fire.gif"),
        ),
      ),
      child: DelayedAnimation(
        delay: 750,
        child: BodyHomeScreen(),
      ),
    ));
  }
}

class BodyHomeScreen extends StatelessWidget {
  const BodyHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(top: 75, bottom: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shadowColor: color_green,
                    elevation: 10,
                    primary: color_green,
                    padding: EdgeInsets.all(15),
                    fixedSize: Size.fromWidth(
                        MediaQuery.of(context).size.width - 100)),
                child: Text(
                  'Mon profil',
                  style: TextStyle(
                      fontFamily: 'Bungee', fontSize: 18, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/home/profile');
                },
              ),
              Divider(
                height: 25,
                thickness: 0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shadowColor: color_yellow,
                    elevation: 10,
                    primary: color_yellow,
                    padding: EdgeInsets.all(15),
                    fixedSize: Size.fromWidth(
                        MediaQuery.of(context).size.width - 100)),
                child: Text(
                  'Mes amis',
                  style: TextStyle(
                      fontFamily: 'Bungee', fontSize: 18, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/home/friends');
                },
              ),
              Divider(
                height: 25,
                thickness: 0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shadowColor: color_brown,
                    elevation: 10,
                    primary: color_brown,
                    padding: EdgeInsets.all(15),
                    fixedSize: Size.fromWidth(
                        MediaQuery.of(context).size.width - 100)),
                child: Text(
                  'La boutique',
                  style: TextStyle(
                      fontFamily: 'Bungee', fontSize: 18, color: Colors.white),
                ),
                onPressed: () {
                  print("");
                },
              ),
              Divider(
                height: 25,
                thickness: 0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shadowColor: color_red,
                    elevation: 10,
                    primary: color_red,
                    padding: EdgeInsets.all(15),
                    fixedSize: Size.fromWidth(
                        MediaQuery.of(context).size.width - 100)),
                child: Text(
                  'Paramètres',
                  style: TextStyle(
                      fontFamily: 'Bungee', fontSize: 18, color: Colors.white),
                ),
                onPressed: () {
                  print("");
                },
              ),
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shadowColor: color_blue,
                    elevation: 10,
                    primary: color_blue,
                    padding: EdgeInsets.all(30),
                    fixedSize: Size.fromWidth(
                        MediaQuery.of(context).size.width - 100)),
                child: Text(
                  'Jouer',
                  style: TextStyle(
                      fontFamily: 'Bungee', fontSize: 18, color: Colors.white),
                ),
                onPressed: () {
                  print("");
                },
              ),
              Divider(
                height: 25,
                thickness: 0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shadowColor: color_purple,
                    elevation: 10,
                    primary: color_purple,
                    padding: EdgeInsets.all(30),
                    fixedSize: Size.fromWidth(
                        MediaQuery.of(context).size.width - 100)),
                child: Text(
                  'Multijoueur',
                  style: TextStyle(
                      fontFamily: 'Bungee', fontSize: 18, color: Colors.white),
                ),
                onPressed: () {
                  print("");
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
