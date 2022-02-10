import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:lordofdungeons/utils/singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider {
  /**
   * Récupération des informations du profil utilisateur
   */
  Future<dynamic> getProfile(BuildContext context) async {
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
    } on DioError catch (e) {
      // showToast(e.response?.data["error"],
      //     context: context,
      //     animation: StyledToastAnimation.slideFromBottomFade,
      //     reverseAnimation: StyledToastAnimation.fade,
      //     position: StyledToastPosition.bottom,
      //     animDuration: Duration(seconds: 1),
      //     duration: Duration(seconds: 6),
      //     curve: Curves.easeInOutCubicEmphasized,
      //     backgroundColor: Colors.red,
      //     borderRadius: BorderRadius.all(Radius.circular(25)));
      return false;
    } catch (e) {
      showToast("Erreur inconnue",
          context: context,
          animation: StyledToastAnimation.slideFromBottomFade,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 6),
          curve: Curves.easeInOutCubicEmphasized,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(25)));
      print('error $e');
      return false;
    }
  }

  /**
   * Modification des informations du profil utilisateur
   */
  Future<dynamic> editProfile(
      BuildContext context, Map<String, dynamic> body) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final res = await Singleton.getDio()
          .put('$url_api/user/edit-profile', data: body);

      final cookies = await Singleton.cookieManager.cookieJar
          .loadForRequest(Uri.parse('$url_api/user/edit-profile'));

      // on récupère les anciennes valeurs des prefs
      final userPrefs = prefs.getString("user");
      Map<String, dynamic> values = json.decode(userPrefs!);
      // concataination des anciennes valeurs avec les nouvelles
      values.addAll(res.data);

      // on ajoute les infos de l'utilisateur dans le stockage local avec les nouvelles valeurs
      prefs.setString('user', jsonEncode(values));
      // on ajoute les cookies
      prefs.setString("cookies", cookies[0].toString());
    } on DioError catch (e) {
      showToast(e.response?.data["error"],
          context: context,
          animation: StyledToastAnimation.slideFromBottomFade,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 6),
          curve: Curves.easeInOutCubicEmphasized,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(25)));
    } catch (e) {
      showToast("Erreur inconnue",
          context: context,
          animation: StyledToastAnimation.slideFromBottomFade,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 6),
          curve: Curves.easeInOutCubicEmphasized,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(25)));
      print('error $e');
    }
  }

  /**
   * Modification du mot de passe utilisateur
   */
  Future<void> editPassword(
      BuildContext context, Map<String, String> body) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final res = await Singleton.getDio()
          .put('$url_api/user/edit-password', data: body);

      final cookies = await Singleton.cookieManager.cookieJar
          .loadForRequest(Uri.parse('$url_api/user/edit-password'));

      // on ajoute les cookies
      prefs.setString("cookies", cookies[0].toString());

      showToast(res.data["message"],
          context: context,
          animation: StyledToastAnimation.slideFromBottomFade,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 5),
          curve: Curves.easeInOutCubicEmphasized,
          backgroundColor: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(25)));

      Navigator.pop(context);
    } on DioError catch (e) {
      showToast(e.response?.data["error"],
          context: context,
          animation: StyledToastAnimation.slideFromBottomFade,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 6),
          curve: Curves.easeInOutCubicEmphasized,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(25)));
    } catch (e) {
      showToast("Erreur inconnue",
          context: context,
          animation: StyledToastAnimation.slideFromBottomFade,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 6),
          curve: Curves.easeInOutCubicEmphasized,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(25)));
      print('error $e');
    }
  }

  /**
   * Modification du mot de passe utilisateur
   */
  Future<void> editPseudo(
      BuildContext context, Map<String, String> body) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final res =
          await Singleton.getDio().put('$url_api/user/edit-pseudo', data: body);

      final cookies = await Singleton.cookieManager.cookieJar
          .loadForRequest(Uri.parse('$url_api/user/edit-pseudo'));

      // on récupère les anciennes valeurs des prefs
      final userPrefs = prefs.getString("user");
      Map<String, dynamic> values = json.decode(userPrefs!);
      // concataination des anciennes valeurs avec les nouvelles
      values.addAll(body);

      // on ajoute les infos de l'utilisateur dans le stockage local avec les nouvelles valeurs
      prefs.setString('user', jsonEncode(values));

      // on ajoute les cookies
      prefs.setString("cookies", cookies[0].toString());

      showToast(res.data["message"],
          context: context,
          animation: StyledToastAnimation.slideFromBottomFade,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 5),
          curve: Curves.easeInOutCubicEmphasized,
          backgroundColor: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(25)));

      Navigator.pop(context, body["pseudo"]);
    } on DioError catch (e) {
      showToast(e.response?.data["error"],
          context: context,
          animation: StyledToastAnimation.slideFromBottomFade,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 6),
          curve: Curves.easeInOutCubicEmphasized,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(25)));
    } catch (e) {
      showToast("Erreur inconnue",
          context: context,
          animation: StyledToastAnimation.slideFromBottomFade,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 6),
          curve: Curves.easeInOutCubicEmphasized,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(25)));
      print('error $e');
    }
  }

  /**
   * Récupérer ses amis
   */
  Future<dynamic> getFriends(BuildContext context) async {
    try {
      final res = await Singleton.getDio().get('$url_api/user/friends');

      return res.data as Map<String, dynamic>;
    } on DioError catch (e) {
      // showToast(e.response?.data["error"],
      //     context: context,
      //     animation: StyledToastAnimation.slideFromBottomFade,
      //     reverseAnimation: StyledToastAnimation.fade,
      //     position: StyledToastPosition.bottom,
      //     animDuration: Duration(seconds: 1),
      //     duration: Duration(seconds: 6),
      //     curve: Curves.easeInOutCubicEmphasized,
      //     backgroundColor: Colors.red,
      //     borderRadius: BorderRadius.all(Radius.circular(25)));
      return false;
    } catch (e) {
      showToast("Erreur inconnue",
          context: context,
          animation: StyledToastAnimation.slideFromBottomFade,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 6),
          curve: Curves.easeInOutCubicEmphasized,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(25)));
      print('error $e');
      return false;
    }
  }

  /**
   * Rechercher des amis
   */
  Future<dynamic> getSearchFriends(BuildContext context, String pseudo) async {
    try {
      final res = await Singleton.getDio().get('$url_api/user/search-friends',
          queryParameters: {"pseudo": pseudo});

      return res.data as Map<String, dynamic>;
    } on DioError catch (e) {
      // showToast(e.response?.data["error"],
      //     context: context,
      //     animation: StyledToastAnimation.slideFromBottomFade,
      //     reverseAnimation: StyledToastAnimation.fade,
      //     position: StyledToastPosition.bottom,
      //     animDuration: Duration(seconds: 1),
      //     duration: Duration(seconds: 6),
      //     curve: Curves.easeInOutCubicEmphasized,
      //     backgroundColor: Colors.red,
      //     borderRadius: BorderRadius.all(Radius.circular(25)));
      return false;
    } catch (e) {
      showToast("Erreur inconnue",
          context: context,
          animation: StyledToastAnimation.slideFromBottomFade,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 6),
          curve: Curves.easeInOutCubicEmphasized,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(25)));
      print('error $e');
      return false;
    }
  }

  /**
   * Ajouter un ami
   */
  Future<dynamic> addFriend(BuildContext context, String pseudo) async {
    try {
      final res = await Singleton.getDio()
          .post('$url_api/user/add-friend', data: {"pseudo": pseudo});

      // message de succès
      showToast(res.data["message"],
          context: context,
          animation: StyledToastAnimation.slideFromBottomFade,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.top,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.easeInOutCubicEmphasized,
          backgroundColor: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(25)));

      return res.data as Map<String, dynamic>;
    } on DioError catch (e) {
      showToast(e.response?.data["error"],
          context: context,
          animation: StyledToastAnimation.slideFromBottomFade,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 6),
          curve: Curves.easeInOutCubicEmphasized,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(25)));
      return false;
    } catch (e) {
      showToast("Erreur inconnue",
          context: context,
          animation: StyledToastAnimation.slideFromBottomFade,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 6),
          curve: Curves.easeInOutCubicEmphasized,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(25)));
      print('error $e');
      return false;
    }
  }

  /**
   * Supprimer un ami
   */
  Future<bool> deleteFriend(BuildContext context, String pseudo) async {
    try {
      final res = await Singleton.getDio().delete('$url_api/user/delete-friend',
          queryParameters: {"pseudo": pseudo});

      // message de succès
      showToast(res.data["message"],
          context: context,
          animation: StyledToastAnimation.slideFromBottomFade,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.top,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.easeInOutCubicEmphasized,
          backgroundColor: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(25)));

      return true;
    } on DioError catch (e) {
      showToast(e.response?.data["error"],
          context: context,
          animation: StyledToastAnimation.slideFromBottomFade,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 6),
          curve: Curves.easeInOutCubicEmphasized,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(25)));
      return false;
    } catch (e) {
      showToast("Erreur inconnue",
          context: context,
          animation: StyledToastAnimation.slideFromBottomFade,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 6),
          curve: Curves.easeInOutCubicEmphasized,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(25)));
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
