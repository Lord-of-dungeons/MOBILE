import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lordofdungeons/commons/delayed_animation.dart';
import 'package:lordofdungeons/providers/user_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

var appBar = AppBar(
  backgroundColor: color_yellow,
);

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  List<dynamic> friends = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    _getFriends();
  }

  void _getFriends() async {
    final data = await UserProvider().getFriends(context);

    if (data != false) {
      setState(() {
        friends = data["users"];
        count = data["count"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SingleChildScrollView(
        child: DelayedAnimation(
          delay: 750,
          child: BodyFriendsScreen(
            friends: friends,
            count: count,
          ),
        ),
      ),
    );
  }
}

class BodyFriendsScreen extends StatelessWidget {
  final List<dynamic> friends;
  final int count;
  const BodyFriendsScreen(
      {Key? key, required this.friends, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List imageList = ['asset images here'];
    return Column(
      children: [
        DelayedAnimation(
          delay: 250,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            alignment: Alignment.center,
            child: Text(
              'Mes amis',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Bungee', fontSize: 18, color: Colors.black),
            ),
          ),
        ),
        DelayedAnimation(
          delay: 250,
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: imageList.length,
              itemBuilder: (context, index) => GFStickyHeader(
                stickyContent: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: color_blue, padding: EdgeInsets.all(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.userPlus,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Ajouter un ami',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Bungee",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        showBarModalBottomSheet(
                          context: context,
                          builder: (context) => SingleChildScrollView(
                            controller: ModalScrollController.of(context),
                            child: ModalAddFriend(),
                          ),
                        );
                      }),
                ),
                stickyContentPosition: GFPosition.end,
                content: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: MediaQuery.of(context).size.height - 260,
                  alignment: Alignment.center,
                  child: ListView.builder(
                      itemCount: count,
                      itemBuilder: (BuildContext context, int index) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              GFCheckboxListTile(
                                title: Text(
                                  friends[index]["pseudo"] ?? "",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "Montserrat",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subTitle: Text(
                                  'En ligne',
                                  style: TextStyle(
                                    color: color_green,
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                avatar: GFAvatar(
                                  backgroundImage: NetworkImage(
                                    "$url_domain${friends[index]["profilePicturePath"]}",
                                  ),
                                  backgroundColor: Colors.transparent,
                                  shape: GFAvatarShape.circle,
                                ),
                                size: 25,
                                activeBgColor: Colors.transparent,
                                activeIcon: FaIcon(
                                  FontAwesomeIcons.times,
                                  color: color_red,
                                ),
                                type: GFCheckboxType.circle,
                                onChanged: (val) {},
                                value: true,
                                inactiveIcon: null,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Divider(),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ModalAddFriend extends StatefulWidget {
  const ModalAddFriend({Key? key}) : super(key: key);

  @override
  _ModalAddFriendState createState() => _ModalAddFriendState();
}

class _ModalAddFriendState extends State<ModalAddFriend> {
  List<dynamic> searchFriends = [];
  int count = 0;

  Future<void> _searchFriends(BuildContext context, String pseudo) async {
    dynamic data = await UserProvider().getSearchFriends(context, pseudo);

    if (data != false) {
      setState(() {
        searchFriends = data["users"];
        count = data["count"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height - 200,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) => GFStickyHeader(
          stickyContent: Container(
            margin: EdgeInsets.only(left: 40, right: 40, top: 20),
            child: TextFormField(
              autocorrect: false,
              showCursor: true,
              decoration: InputDecoration(
                icon: Icon(Icons.search_off_rounded),
                labelText: 'pseudo',
              ),
              onChanged: (value) {
                if (value.length >= 3) {
                  _searchFriends(context, value);
                } else if (value.isEmpty) {
                  setState(() {
                    searchFriends = [];
                    count = 0;
                  });
                }
              },
            ),
          ),
          content: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: ListView.builder(
                itemCount: count,
                itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        GFCheckboxListTile(
                          title: Text(
                            searchFriends[index]["pseudo"] ?? "",
                            style: TextStyle(
                              color: Colors.black87,
                              fontFamily: "Montserrat",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          avatar: GFAvatar(
                            backgroundImage: NetworkImage(
                              "$url_domain${searchFriends[index]["profilePicturePath"]}",
                            ),
                            backgroundColor: Colors.transparent,
                            shape: GFAvatarShape.circle,
                          ),
                          size: 25,
                          activeBgColor: Colors.transparent,
                          activeIcon: FaIcon(
                            FontAwesomeIcons.plus,
                            color: Colors.grey[700],
                          ),
                          type: GFCheckboxType.circle,
                          onChanged: (val) {},
                          value: true,
                          inactiveIcon: null,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Divider(),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
