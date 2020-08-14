import 'package:black_dragon_app/src/data/bloc/validators.dart';

import 'dart:async';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {

  final _emailController  = BehaviorSubject<String>();
  final _passController   = BehaviorSubject<String>();

  // Recuperar los datos del stream
  Stream<String> get emailStream      => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream   => _passController.stream.transform(validarPassword);
  Stream<bool>   get formValidStream  => Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // Insertar valores al Stream
  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword  => _passController.sink.add;

  // Obtener el ultimo valor ingresado a los streams
  String get email    => _emailController.value;
  String get password => _passController.value;


  dispose() {
    _emailController?.close();
    _passController?.close();
  }
}