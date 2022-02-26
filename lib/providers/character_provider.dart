import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:lordofdungeons/utils/singleton.dart';

class CharacterProvider {
  /**
   * Récupération des personnages de l'utilisateur
   */
  Future<dynamic> getCharacters(BuildContext context) async {
    try {
      final res = await Singleton.getDio().get('$url_api/character');
      return res.data;
    } on DioError catch (e) {
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
   * Création d'un personnage
   */
  Future<dynamic> addCharacter(
      BuildContext context, String name, int idVocation) async {
    try {
      Map<String, dynamic> body = {"name": name, "idVocation": idVocation};
      final res =
          await Singleton.getDio().post('$url_api/character/add', data: body);

      showToast(res.data["message"],
          context: context,
          animation: StyledToastAnimation.slideFromBottomFade,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 3),
          curve: Curves.easeInOutCubicEmphasized,
          backgroundColor: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(25)));

      Navigator.of(context).pop(true);
    } on DioError catch (e) {
      showToast(e.response!.data["error"],
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
   * Suppression du personnage
   */
  Future<bool> deleteCharacter(BuildContext context, int idCharacter) async {
    try {
      final res =
          await Singleton.getDio().delete('$url_api/character/$idCharacter');

      showToast(res.data["message"],
          context: context,
          animation: StyledToastAnimation.slideFromBottomFade,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 3),
          curve: Curves.easeInOutCubicEmphasized,
          backgroundColor: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(25)));

      return true;
    } on DioError catch (e) {
      showToast(e.response!.data["error"],
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
}
