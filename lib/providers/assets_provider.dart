import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:lordofdungeons/utils/singleton.dart';

class AssetsProvider {
  /**
   * Récupération des images
   */
  Future<dynamic> getImage(BuildContext context, String imgPath) async {
    try {
      final res = await Singleton.getDio().get('$url_api/public/$imgPath');
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
}
