import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lordofdungeons/providers/user_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:lordofdungeons/utils/singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider {
  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final res = await Singleton.getDio().post('$url_api/auth/login',
          data: {'email': email, 'password': password});

      // print(res.headers);
      final cookies = await Singleton.cookieManager.cookieJar
          .loadForRequest(Uri.parse('$url_api/auth/login'));

      // on ajoute les infos de l'utilisateur dans le stockage local
      prefs.setString('user', jsonEncode(res.data));
      // on ajoute les cookies
      prefs.setString("cookies", cookies[0].toString());

      // redirection
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      print('error $e');
    }
  }

  Future<void> autoLogIn(BuildContext context) async {
    try {
      final res = await UserProvider().getProfile();

      if (res == false) return;
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      print('autoLogIn : $e');
    }
  }
}
