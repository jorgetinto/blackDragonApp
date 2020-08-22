import 'dart:io';

import 'package:black_dragon_app/src/data/models/estudiante_model.dart';
import 'package:black_dragon_app/src/data/providers/estudiante_provider.dart';

import 'package:rxdart/rxdart.dart';
import 'dart:async';

class EstudianteBloc {

  final _estudiantesController  = new BehaviorSubject<EstudianteModel>();
  final _estudianteProvider     = new EstudiantesProvider();

  Stream<EstudianteModel> get estudianteStream => _estudiantesController.stream;

  void buscarEstudiante() async {
    final des = await _estudianteProvider.buscarEstudiante();
    _estudiantesController.add(des);    
  }

  void crearEstudianteBase() async {
    final des = await _estudianteProvider.crearEstudianteBase();
    _estudiantesController.add(des);    
  }

  void editarProducto(EstudianteModel estudiante) async {
    final des = await _estudianteProvider.editarEstudiante(estudiante);
    _estudiantesController.add(des);    
  }

  Future<String> subirFoto(File foto) async {
    final fotoUrl = await _estudianteProvider.subirImagen(foto);
    return fotoUrl;
  }

   dispose() {
    _estudiantesController?.close();
  }
}