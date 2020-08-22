
import 'package:black_dragon_app/src/data/bloc/provider_bloc.dart';
import 'package:black_dragon_app/src/data/preferencias_usuario/preferenciasUsuario.dart';
import 'package:black_dragon_app/src/ui/pages/authenticate/login_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('es'),
        ],
      ),
    );
  }
}
