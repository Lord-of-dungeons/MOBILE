import 'dart:convert';
import 'package:http/http.dart';
import 'package:lordofdungeons/utils/constants.dart';

class UserProvider {
  Future<bool> getProfile() async {
    try {
      Response res = await get(Uri.parse('$url_api/user/profile'));
      print('getPerofile : ${res.headers}');
      // si y'a une erreur
      if (res.statusCode != 200) {
        // récupération du body
        var decodedResponse = json.decode(res.body);
        throw (decodedResponse['error']);
      }
      return true;
    } catch (e) {
      print('error $e');
      return false;
    }
  }
}
