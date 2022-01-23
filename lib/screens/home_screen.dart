import 'package:flutter/material.dart';
import 'package:lordofdungeons/providers/user_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:lottie/lottie.dart';

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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: UserProvider().getProfile(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return BodyHomeScreen(
                    state: snapshot.data,
                  );
                }
                return LoaderHomeScreen();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BodyHomeScreen extends StatelessWidget {
  final dynamic state;
  const BodyHomeScreen({Key? key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 50,
      ),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  'https://c.tenor.com/T8tXOKz3hXIAAAAC/dark-souls.gif',
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
            Text(state["firstname"])
          ],
        ),
      ),
    );
  }
}

class LoaderHomeScreen extends StatelessWidget {
  const LoaderHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/loader_1.json',
          ),
        ],
      ),
    );
  }
}
