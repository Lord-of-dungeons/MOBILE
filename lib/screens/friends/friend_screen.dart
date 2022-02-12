import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/commons/loader.dart';
import 'package:lordofdungeons/providers/user_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';

var appBar = AppBar(
  backgroundColor: color_yellow,
  title: Text("Mes amis"),
);

class FriendScreen extends StatefulWidget {
  final pseudo;
  const FriendScreen({Key? key, required this.pseudo}) : super(key: key);

  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  late Map<String, dynamic> state;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    _getFriend(widget.pseudo);
  }

  void dipose() {
    super.dispose();
  }

  void _getFriend(String pseudo) async {
    final data = await UserProvider().getFriend(context, pseudo);

    if (data != false) {
      setState(() {
        state = data;
        loaded = true;
      });
    }
  }

  void _deleteFriend(String pseudo) async {
    final res = await UserProvider().deleteFriend(context, pseudo);
    if (res == true) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SingleChildScrollView(
        child: loaded
            ? BodyFriendScreen(
                state: state,
                getfriend: _getFriend,
                deleteFriend: _deleteFriend,
              )
            : Loader(),
      ),
    );
  }
}

class BodyFriendScreen extends StatelessWidget {
  final Map<String, dynamic> state;
  final void Function(String pseudo) getfriend;
  final void Function(String pseudo) deleteFriend;
  //
  const BodyFriendScreen(
      {Key? key,
      required this.state,
      required this.getfriend,
      required this.deleteFriend})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DelayedAnimation(
      delay: 250,
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height +
            20 -
            (appBar.preferredSize.height),
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                        "$url_domain${state['profilePicturePath']}",
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state['pseudo'],
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Inscrit depuis le " +
                                DateFormat('dd/MM/yyyy').format(
                                    DateTime.parse(state['dateCreate'])),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 15,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
