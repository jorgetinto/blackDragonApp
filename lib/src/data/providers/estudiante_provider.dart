
import 'dart:convert';
import 'dart:io';

import 'package:black_dragon_app/src/data/models/estudiante_model.dart';
import 'package:black_dragon_app/src/data/preferencias_usuario/preferenciasUsuario.dart';

import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';


class EstudiantesProvider {
  
  final String _url = 'https://blackdragons.firebaseio.com/';
  final _prefs = new PreferenciasUsuario();

  Future<EstudianteModel>  buscarEstudiante()  async {
    final url = '$_url/estudiante/${_prefs.uid}.json?auth=${_prefs.token}';
    final resp = await http.get(url);
    final respModel = estudianteModelFromJson(resp.body.toString());
    _prefs.uidInstructor   = respModel.intructor.id;
    return respModel;
  } 

  Future<EstudianteModel> crearEstudianteBase() async {

    InfoMedica infoMedica = new InfoMedica();
    infoMedica.nombre = "Sin información";

    MetodoPago metodoPago = new MetodoPago();
    metodoPago.nombre ="efectivo";

    Intructor intructor = new Intructor();
    intructor.apellido = "Villalobos";
    intructor.nombre = "Rodrigo";
    intructor.id ="XnhjiYXJx06mrQg05MknMQ";

    Grado grado = new Grado();
    grado.fechaExamen = "01/01/1900";
    grado.gradoActual = true;
    grado.notaExamen = 0;
    grado.color = "Blanco";
    grado.nombre = "10° Gup";

    Dojang dojang = new Dojang();
    dojang.ciudad = "-";
    dojang.direccion = "-";
    dojang.escuela = "-";
    dojang.instructor = "-";
    dojang.sede = "-";

    EstudianteModel estudiante = new EstudianteModel();
    estudiante.apellidos = "-";
    estudiante.correo = "-";
    estudiante.dojang = dojang;
    estudiante.fechaNacimiento = "-";
    estudiante.fono = "-";
    estudiante.grado = grado;
    estudiante.intructor = intructor;
    estudiante.metodoPago = metodoPago;
    estudiante.infoMedica = infoMedica;
    estudiante.motivacion = "Ingrese una motivación por la cual entrena";
    estudiante.nombre = "-";
    estudiante.ranking = 0;
    estudiante.rut = "-";
    estudiante.imagen = "-";
    
    
    final url = '$_url/estudiante/${_prefs.uid}.json?auth=${_prefs.token}';
    final resp = await http.post(url, body: estudianteModelToJson(estudiante));
    final respModel = estudianteModelFromJson(resp.body.toString());
    return respModel;
  }

  Future<EstudianteModel> editarEstudiante(EstudianteModel estudiante) async {
    final url = '$_url/estudiante/${_prefs.uid}.json?auth=${_prefs.token}';
    final resp = await http.put(url, body: estudianteModelToJson(estudiante));
    final respModel = estudianteModelFromJson(resp.body.toString());
    return respModel;
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