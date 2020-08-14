
import 'package:black_dragon_app/src/data/providers/estudiante_provider.dart';
import 'package:black_dragon_app/src/models/estudiante_model.dart';

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

   dispose() {
    _estudiantesController?.close();
  }
}