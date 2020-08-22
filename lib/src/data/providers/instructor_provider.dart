
import 'package:black_dragon_app/src/data/models/Instructor_model.dart';
import 'package:black_dragon_app/src/data/preferencias_usuario/preferenciasUsuario.dart';

import 'package:http/http.dart' as http;


class InstructorProvider {
  
  final String _url = 'https://blackdragons.firebaseio.com/';
  final _prefs = new PreferenciasUsuario();

  Future<InstructorModel>  buscarInstructor()  async {    
    final url = '$_url/instructor/${_prefs.uidInstructor}.json?auth=${_prefs.token}';
    final resp = await http.get(url);
    final respModel = instructorModelFromJson(resp.body.toString());
    return respModel;
  } 
}