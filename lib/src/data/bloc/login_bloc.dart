import 'package:black_dragon_app/src/data/bloc/validators/validators_login_form.dart';
import 'package:black_dragon_app/src/data/providers/usuario_provider.dart';

import 'dart:async';
import 'package:rxdart/rxdart.dart';

class LoginBloc with ValidatorsLoginForm {

  final _emailController          = BehaviorSubject<String>();
  final _passController           = BehaviorSubject<String>();
  final _usuarioProvider          = UsuarioProvider();

  // Recuperar los datos del stream
  Stream<String> get emailStream             => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream          => _passController.stream.transform(validarPassword);
  Stream<bool>   get formValidStream         => Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // Insertar valores al Stream
  Function(String) get changeEmail            => _emailController.sink.add;
  Function(String) get changePassword         => _passController.sink.add;

  // Obtener el ultimo valor ingresado a los streams
  String get email           => _emailController.value;
  String get password        => _passController.value;

  Future<Map<String, dynamic>> login(String email, String password) async {
    final resultado = await _usuarioProvider.login(email, password);
    return resultado;
  }

  Future<Map<String, dynamic>> registerWithEmailAnfPassword(String email, String password) async {
    final resultado = await _usuarioProvider.registerWithEmailAnfPassword(email, password);
    return resultado;
  }

  Future<Map<String, dynamic>> cambiarPassword(String password) async {
    return await _usuarioProvider.changePassword(password);
  }

  Future<Map<String, dynamic>> signOut() async {
    final resultado = await _usuarioProvider.signOut();
    changeEmail('');
    changePassword('');
    return resultado;
  }

  dispose() {
    _emailController?.close();
    _passController?.close();
  }
}