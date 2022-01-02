import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:lordofdungeons/providers/user_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:lordofdungeons/utils/singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider {
  /**
   * Connexion de l'utilisateur
   */
  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final res = await Singleton.getDio().post('$url_api/auth/login',
          data: {'email': email, 'password': password});

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

  /**
   * Connexion de l'utilisateur
   */
  Future<Map<String, dynamic>?> loginFacebook(BuildContext context) async {
    try {
      await FacebookAuth.instance
          .login(permissions: ["public_profile", "email", "user_birthday"]);

      final result =
          await FacebookAuth.instance.getUserData(fields: "name,email,id");
      final name = result["name"];

      // récupération des nom/prénom
      final firstname = name.toString().split(" ")[0];
      final lastname = name.toString().split(" ")[1];

      final data = {
        "firstname": firstname,
        "lastname": lastname,
        "email": result["email"],
        "facebookId": result["id"]
      };

      // on teste la connexion pour voir si l'utilisateur est déjà authentifié avec facebook

      return data;
    } catch (e) {
      print('error $e');
      return null;
    }
  }

  /**
   * Inscription de l'utilisateur
   */
  Future<void> register(BuildContext context, Map<String, dynamic> data) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final res = await Singleton.getDio()
          .post('$url_api/auth/register', data: {...data});

      final cookies = await Singleton.cookieManager.cookieJar
          .loadForRequest(Uri.parse('$url_api/auth/register'));

      // on ajoute les infos de l'utilisateur dans le stockage local
      prefs.setString('user', jsonEncode(res.data));
      // on ajoute les cookies
      prefs.setString("cookies", cookies[0].toString());

      // on supprime les données du formulaire en stockage
      prefs.remove('register_form');

      // redirection
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      print('error $e');
    }
  }

/**
 * Auto connexion au lancement de la page.
 * On utilise la récupération du profil comme test car si y'a un token expiré mais un refresh_token
 * l'utilisateur sera réauthentifié dynamiquement
 */
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
