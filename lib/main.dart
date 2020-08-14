
import 'package:black_dragon_app/src/data/bloc/provider_bloc.dart';
import 'package:black_dragon_app/src/pages/authenticate/login_page.dart';
import 'package:black_dragon_app/src/utils/preferencias_usuario/preferenciasUsuario.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderBloc(
        child: MaterialApp(
        title: 'Black Dragons App',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: LoginPage()
        ),
      ),
    );
  }
}