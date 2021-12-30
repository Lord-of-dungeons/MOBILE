import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lordofdungeons/utils/constants.dart';

class AuthProvider {
  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      Response res = await post(Uri.parse('$url_api/auth/login'),
          body: {'email': email, 'password': password});

      // si y'a une erreur
      if (res.statusCode != 200) {
        // récupération du body
        var decodedResponse = json.decode(res.body);
        throw (decodedResponse['error']);
      }
      // redirection
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print('error $e');
    }
  }
}
