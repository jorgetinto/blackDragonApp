import 'package:black_dragon_app/src/data/bloc/changePassword_bloc.dart';
import 'package:black_dragon_app/src/data/bloc/estudiante_bloc.dart';
import 'package:black_dragon_app/src/data/bloc/login_bloc.dart';

import 'package:flutter/material.dart';

class ProviderBloc extends InheritedWidget {

  final loginBloc       = new LoginBloc();
  final _estudianteBloc = new EstudianteBloc();
  final _cambiarPassBloc = new ChangePasswordBloc();

  static ProviderBloc _instancia;

  factory ProviderBloc({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new ProviderBloc._internal(key: key, child: child);
    }
    return _instancia;
  }

  ProviderBloc._internal({Key key, Widget child}) : super(key: key, child: child);  

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ){
   return context.dependOnInheritedWidgetOfExactType<ProviderBloc>().loginBloc;
  }

  static EstudianteBloc estudianteBloc ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<ProviderBloc>()._estudianteBloc;
  }

  static ChangePasswordBloc cambiarPassBloc ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<ProviderBloc>()._cambiarPassBloc;
  }
}