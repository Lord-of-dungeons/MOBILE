import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lordofdungeons/providers/user_provider.dart';
import 'package:lordofdungeons/utils/constants.dart';
import 'package:lordofdungeons/utils/singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
   * Connexion de l'utilisateur avec Facebook
   */
  Future<void> loginFacebook(BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
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
        "facebook_id": result["id"]
      };
      prefs.setString('register_form', jsonEncode(data));

      //
      // on teste la connexion pour voir si l'utilisateur est déjà authentifié avec facebook
      //
      final res = await Singleton.getDio().post('$url_api/auth/login/facebook',
          data: {'email': data["email"], 'facebook_id': result["id"]});

      final cookies = await Singleton.cookieManager.cookieJar
          .loadForRequest(Uri.parse('$url_api/auth/login/facebook'));

      // on ajoute les infos de l'utilisateur dans le stockage local
      prefs.setString('user', jsonEncode(res.data));
      // on ajoute les cookies
      prefs.setString("cookies", cookies[0].toString());

      // redirection si la connexion a réussi
      Navigator.pushNamed(context, '/home');
    } on PlatformException catch (e) {
      print("facebook : $e");
      return;
    } catch (e) {
      print('error $e');

      // sinon on redirige l'utilisateur vers le formulaire d'inscription complémentaire car ça veut dire qu'il n'est pas encore inscrit
      Navigator.pushNamed(context, '/register/informations');
    }
  }

  /**
   * Connexion de l'utilisateur avec Google
   */
  Future<void> loginGoogle(BuildContext context) async {
    try {
      await dotenv.load(fileName: ".env");
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      //
      // Google connexion
      //
      GoogleSignIn _googleSignIn =
          GoogleSignIn(clientId: dotenv.env['GOOGLE_CLIENT_ID']);
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      // formatage nom/prénom
      final displayName = googleSignInAccount!.displayName;
      final firstname = displayName!.split(" ")[0];
      final lastname = displayName.split(" ")[1];

      // formatage des données
      final data = {
        "firstname": firstname,
        "lastname": lastname,
        "email": googleSignInAccount.email,
        "google_id": googleSignInAccount.id
      };
      // maj dans le stockage local
      prefs.setString('register_form', jsonEncode(data));

      //
      // on teste la connexion pour voir si l'utilisateur est déjà authentifié avec google
      //
      final res = await Singleton.getDio().post('$url_api/auth/login/google',
          data: {'email': data["email"], 'google_id': data["google_id"]});

      final cookies = await Singleton.cookieManager.cookieJar
          .loadForRequest(Uri.parse('$url_api/auth/login/google'));

      // on ajoute les infos de l'utilisateur dans le stockage local
      prefs.setString('user', jsonEncode(res.data));
      // on ajoute les cookies
      prefs.setString("cookies", cookies[0].toString());

      // redirection si la connexion a réussi
      Navigator.pushNamed(context, '/home');
    } on PlatformException catch (e) {
      print("google : $e");
      return;
    } catch (e) {
      print('error $e');
      // sinon on redirige l'utilisateur vers le formulaire d'inscription complémentaire car ça veut dire qu'il n'est pas encore inscrit
      Navigator.pushNamed(context, '/register/informations');
    }
  }

  /**
   * Connexion de l'utilisateur avec Google
   */
  Future<void> loginGithub(BuildContext context) async {
    try {
      await dotenv.load(fileName: ".env");
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      //
      // Github connexion
      //
      final GitHubSignIn gitHubSignIn = GitHubSignIn(
          clientId: dotenv.env['GITHUB_CLIENT_ID'] ?? "",
          clientSecret: dotenv.env['GITHUB_CLIENT_SECRET'] ?? "",
          redirectUrl: "com.lordofdungeons://");
      var result = await gitHubSignIn.signIn(context);

      switch (result.status) {
        case GitHubSignInResultStatus.ok:

          // on récupère les infos du profil github
          final githubResponse =
              await Singleton.getDio().get('https://api.github.com/user',
                  options: Options(headers: {
                    'accept': 'application/vnd.github.v3+json',
                    'authorization': 'token ${result.token}',
                  }));

          // formatage nom/prénom
          final displayName = githubResponse.data["name"];
          final firstname = displayName!.split(" ")[0];
          final lastname = displayName.split(" ")[1];

          // formatage des données
          final data = {
            "firstname": firstname,
            "lastname": lastname,
            "pseudo": githubResponse.data["login"],
            "email": githubResponse.data["email"] ?? "",
            "github_id": githubResponse.data["id"],
          };

          // maj dans le stockage local
          prefs.setString('register_form', jsonEncode(data));

          //
          // on teste la connexion pour voir si l'utilisateur est déjà authentifié avec google
          //
          final res = await Singleton.getDio().post(
              '$url_api/auth/login/github',
              data: {'email': data["email"], 'github_id': data["github_id"]});

          final cookies = await Singleton.cookieManager.cookieJar
              .loadForRequest(Uri.parse('$url_api/auth/login/github'));

          // on ajoute les infos de l'utilisateur dans le stockage local
          prefs.setString('user', jsonEncode(res.data));
          // on ajoute les cookies
          prefs.setString("cookies", cookies[0].toString());

          // redirection si la connexion a réussi
          Navigator.pushNamed(context, '/home');

          break;

        case GitHubSignInResultStatus.cancelled:
          return;
        case GitHubSignInResultStatus.failed:
          //TODO: toast avec erreur
          break;
      }
    } on PlatformException catch (e) {
      print("github : $e");
      return;
    } catch (e) {
      print('error $e');
      // sinon on redirige l'utilisateur vers le formulaire d'inscription complémentaire car ça veut dire qu'il n'est pas encore inscrit
      Navigator.pushNamed(context, '/register/informations');
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
   * Inscription de l'utilisateur par facebook
   */
  Future<void> registerWithFacebook(
      BuildContext context, Map<String, dynamic> data) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final res = await Singleton.getDio()
          .post('$url_api/auth/register/facebook', data: {...data});

      final cookies = await Singleton.cookieManager.cookieJar
          .loadForRequest(Uri.parse('$url_api/auth/register/facebook'));

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
   * Inscription de l'utilisateur par google
   */
  Future<void> registerWithGoogle(
      BuildContext context, Map<String, dynamic> data) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final res = await Singleton.getDio()
          .post('$url_api/auth/register/google', data: {...data});

      final cookies = await Singleton.cookieManager.cookieJar
          .loadForRequest(Uri.parse('$url_api/auth/register/google'));

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
   * Inscription de l'utilisateur par github
   */
  Future<void> registerWithGithub(
      BuildContext context, Map<String, dynamic> data) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final res = await Singleton.getDio()
          .post('$url_api/auth/register/github', data: {...data});

      final cookies = await Singleton.cookieManager.cookieJar
          .loadForRequest(Uri.parse('$url_api/auth/register/github'));

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
