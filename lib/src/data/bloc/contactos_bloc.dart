
import 'package:black_dragon_app/src/data/models/contactos_model.dart';
import 'package:black_dragon_app/src/data/providers/contactos_provider.dart';

import 'package:rxdart/rxdart.dart';
import 'dart:async';

class ContactosBloc {

  final _contactosController  = new BehaviorSubject<List<ContactosModel>>();
  final _contactosProvider     = new ContactosProvider();

  Stream<List<ContactosModel>> get contactosStream => _contactosController.stream;

  void buscarContactos() async {
    final des = await _contactosProvider.buscarContactos();
    _contactosController.sink.add(des);    
  }

  void editarContacto(ContactosModel contacto) async {
    await _contactosProvider.editarContacto(contacto);
    this.buscarContactos();
  }

   dispose() {
    _contactosController?.close();
  }
}