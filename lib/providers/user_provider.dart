import 'dart:convert';

import 'package:lordofdungeons/utils/constants.dart';
import 'package:lordofdungeons/utils/singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider {
  /**
   * Récupération des informations du profil utilisateur
   */
  Future<dynamic> getProfile() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final res = await Singleton.getDio().get('$url_api/user/profile');

      final cookies = await Singleton.cookieManager.cookieJar
          .loadForRequest(Uri.parse('$url_api/user/profile'));

      // on ajoute les infos de l'utilisateur dans le stockage local
      prefs.setString('user', jsonEncode(res.data));
      // on ajoute les cookies
      prefs.setString("cookies", cookies[0].toString());

      return res.data;
    } catch (e) {
      print('error $e');
      return false;
    }
  }

/**
 * Récupération des informations de l'utilisateur dans le stockage local
 */
  Future<dynamic> getUserPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final dynamic user = prefs.getString('user');

    if (user == null) return;

    return jsonDecode(user);
  }
}
