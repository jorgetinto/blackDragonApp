
import 'dart:convert';

import 'package:black_dragon_app/src/data/models/contactos_model.dart';
import 'package:black_dragon_app/src/data/preferencias_usuario/preferenciasUsuario.dart';

import 'package:http/http.dart' as http;


class ContactosProvider {
  
  final String _url = 'https://blackdragons.firebaseio.com/';
  final _prefs = new PreferenciasUsuario();

  Future<List<ContactosModel>>  buscarContactos()  async {    
    final url = '$_url/contactos.json?auth=${_prefs.token}';
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<ContactosModel> contactos = new List();
    if (decodedData == null) return [];
    if (decodedData['error'] != null) return [];

    decodedData.forEach((id, cont) {
       final contactoslis = ContactosModel.fromJson(cont);
       contactoslis.id = id;
       contactos.add(contactoslis);
    });
    
    return contactos;
  } 
}