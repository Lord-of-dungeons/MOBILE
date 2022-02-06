import 'package:flutter/material.dart';
import 'package:lordofdungeons/screens/friends/friends_screen.dart';
import 'package:lordofdungeons/screens/home_screen.dart';
import 'package:lordofdungeons/screens/login_screen.dart';
import 'package:lordofdungeons/screens/profile/password_edit_screen.dart';
import 'package:lordofdungeons/screens/profile/pseudo_edit_screen.dart';
import 'package:lordofdungeons/screens/profile/profile_edit_screen.dart';
import 'package:lordofdungeons/screens/profile/profile_screen.dart';
import 'package:lordofdungeons/screens/register_address_screen.dart';
import 'package:lordofdungeons/screens/register_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case '/home/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/home/profile/edit':
        final args = settings.arguments as dynamic;
        final values = {
          "firstname": args["firstname"],
          "lastname": args["lastname"],
          "pseudo": args["pseudo"],
          "email": args["email"],
          "birthday": args["birthday"],
          "newsletter": args["newsletter"],
          "profilePicturePath": args["profilePicturePath"],
          // address
        };

        return MaterialPageRoute(
            builder: (_) => ProfileEditScreen(state: values));
      case '/home/profile/edit-password':
        return MaterialPageRoute(builder: (_) => PasswordEditScreen());
      case '/home/profile/edit-pseudo':
        return MaterialPageRoute(builder: (_) => PseudoEditScreen());
      case '/home/friends':
        return MaterialPageRoute(builder: (_) => FriendsScreen());
      case '/register/informations':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case '/register/address':
        return MaterialPageRoute(builder: (_) => RegisterAddressScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 20,
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logo_fond_blanc.png",
                    width: 250,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Erreur",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Bungee',
                        fontSize: 18,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
