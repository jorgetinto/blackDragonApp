
import 'dart:convert';
import 'dart:io';

import 'package:black_dragon_app/src/models/estudiante_model.dart';
import 'package:black_dragon_app/src/utils/preferencias_usuario/preferenciasUsuario.dart';

import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';


class EstudiantesProvider {
  
  final String _url = 'https://blackdragons.firebaseio.com/';
  final _prefs = new PreferenciasUsuario();

  Future<EstudianteModel>  buscarEstudiante()  async {
    final url = '$_url/estudiante/${_prefs.uid}.json?auth=${_prefs.token}';
    final resp = await http.get(url);
    final prodTemp = estudianteModelFromJson(resp.body.toString());
    return prodTemp;
  } 

  Future<bool> editarEstudiante(EstudianteModel estudiante) async {
    final url = '$_url/estudiante/${_prefs.uid}.json?auth=${_prefs.token}';
    final resp = await http.put(url, body: estudianteModelToJson(estudiante));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<String> subirImagen(File imagen ) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/jpino/image/upload?upload_preset=xuppesfg');

    final mimeType = mime(imagen.path).split('/');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType( mimeType[0], mimeType[1] )
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salio mal');
      print( resp.body );
      return null;
    }

    final respData = json.decode(resp.body);
    print( respData);

    return respData['secure_url'];
  } 
}