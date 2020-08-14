import 'package:black_dragon_app/src/utils/preferencias_usuario/preferenciasUsuario.dart';
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
       return {'ok': false, 'mensaje': decodedResp['error']['message']};
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

  Future<Map<String, dynamic>> signOut() async {

    _prefs.token = '';
    _prefs.uid   = '';
    
    return {'ok': true};
  }

}