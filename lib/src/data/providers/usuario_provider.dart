import 'package:black_dragon_app/src/data/preferencias_usuario/preferenciasUsuario.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class UsuarioProvider {

  final String _firebaseToken = 'AIzaSyB_Kc59keGuSPh35ck9oNV8OMrbbHCP3oQ';
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String email, String password) async {
    
    final authData = {
      'email'   : email,
      'password': password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
        _prefs.token = decodedResp['idToken'];
        _prefs.uid   = decodedResp['localId'];
        return {'ok': true, 'token': decodedResp['idToken']};
    } else {
        String error = '';
          if (decodedResp['error']['message'] == 'EMAIL_NOT_FOUND' || decodedResp['error']['message'] == 'INVALID_PASSWORD') {
            error = 'Correo o contraseña son incorrectos!';
          }
          else if (decodedResp['error']['message'] == 'USER_DISABLED') {
            error = 'Cuenta de usuario desabilitada';
          }else {
            error = decodedResp['error']['message'];
          }
       return {'ok': false, 'mensaje': error};
    }

  }

  Future<Map<String, dynamic>> registerWithEmailAnfPassword(String email, String password) async {
    
    final authData = {
      'email'   : email,
      'password': password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
       _prefs.token = decodedResp['idToken'];
       _prefs.uid   = decodedResp['localId'];
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
       return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }

  }

  Future<Map<String, dynamic>> changePassword(String password) async {
    
    final authData = {
      'idToken': _prefs.token,
      'password': password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:update?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
       _prefs.token = decodedResp['idToken'];
       _prefs.uid   = decodedResp['localId'];
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
       return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }

  }

  Future<Map<String, dynamic>> signOut() async {

    _prefs.token = '';
    _prefs.uid   = '';
    
    return {'ok': true};
  }

}