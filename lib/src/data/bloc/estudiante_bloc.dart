import 'dart:io';

import 'package:black_dragon_app/src/data/models/contactos_model.dart';
import 'package:black_dragon_app/src/data/models/estudiante_model.dart';
import 'package:black_dragon_app/src/data/providers/contactos_provider.dart';
import 'package:black_dragon_app/src/data/providers/estudiante_provider.dart';

import 'package:rxdart/rxdart.dart';
import 'dart:async';

class EstudianteBloc {

  final _estudiantesController  = new BehaviorSubject<EstudianteModel>();
  final _estudianteByIdController  = new BehaviorSubject<EstudianteModel>();
  final _estudianteProvider     = new EstudiantesProvider();
  final _contactosProvider      = new ContactosProvider();

  Stream<EstudianteModel> get estudianteStream =>     _estudiantesController.stream;
  Stream<EstudianteModel> get estudianteByIdStream => _estudianteByIdController.stream;

  void buscarEstudiante() async {
    final des = await _estudianteProvider.buscarEstudiante();
    _estudiantesController.add(des);    
  }

  void buscarEstudiantebyId(String uid) async {
    final des = await _estudianteProvider.buscarEstudiantebyId(uid);
    _estudianteByIdController.add(des);    
  }

  void crearEstudianteBase() async {
    final des = await _estudianteProvider.crearEstudianteBase();
    _estudiantesController.add(des);    
  }

  void editarEstudiante(EstudianteModel estudiante) async {
    final des = await _estudianteProvider.editarEstudiante(estudiante);

    ContactosModel contacto = new ContactosModel();
    contacto.apellido       = des.apellidos;
    contacto.nombre         = des.nombre;
    contacto.fono           = des.fono;
    contacto.sede           = des.dojang.sede;
    _contactosProvider.editarContacto(contacto);

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