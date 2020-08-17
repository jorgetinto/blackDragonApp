import 'package:black_dragon_app/src/data/bloc/validators/validators_login_form.dart';
import 'package:black_dragon_app/src/data/providers/usuario_provider.dart';

import 'dart:async';
import 'package:rxdart/rxdart.dart';

class ChangePasswordBloc with ValidatorsLoginForm {

  final _passwordController           = BehaviorSubject<String>();
  final _passwordReperirController    = BehaviorSubject<String>();
  final _usuarioProvider              = UsuarioProvider();

  // Recuperar los datos del stream
  Stream<String> get passwordStream          => _passwordController.stream.transform(validarPassword);
  Stream<String> get repetirPasswordStream   => _passwordReperirController.stream.transform(validarPassword);
  Stream<bool> get formValidChangePass       => Rx.combineLatest3( passwordStream, repetirPasswordStream, confirmPassword, (e, p, c) => (0 == p.compareTo(c)));

  // Insertar valores al Stream
  Function(String) get changePassword         => _passwordController.sink.add;
  Function(String) get changerepetirPassword  => _passwordReperirController.sink.add;

  // Obtener el ultimo valor ingresado a los streams
  String get password                         => _passwordController.value;
  String get repetirPassword                  => _passwordReperirController.value;
  
  Stream<String> get confirmPassword => 
    _passwordReperirController.stream.transform(validarPassword)
      .doOnData((String c){
        if (0 != _passwordController.value.compareTo(c)){
          _passwordReperirController.addError("Las contraseñas no coinciden!");
        }
      });

  Future<Map<String, dynamic>> cambiarPassword(String password) async {
    return await _usuarioProvider.changePassword(password);
  }

  dispose() {
    _passwordController?.close();
    _passwordReperirController?.close();
  }
}