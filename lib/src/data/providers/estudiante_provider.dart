
import 'package:black_dragon_app/src/models/estudiante_model.dart';
import 'package:black_dragon_app/src/utils/preferencias_usuario/preferenciasUsuario.dart';

import 'package:http/http.dart' as http;


class EstudiantesProvider {
  
  final String _url = 'https://blackdragons.firebaseio.com/';
  final _prefs = new PreferenciasUsuario();

  Future<EstudianteModel>  buscarEstudiante()  async {
    final url = '$_url/estudiante/${_prefs.uid}.json?auth=${_prefs.token}';
    final resp = await http.get(url);
    final prodTemp = estudianteModelFromJson(resp.body.toString());
    return prodTemp;
  }  

  //Future<EstudianteModel> get buscarEstudiante => this._buscarEstudiante();
}