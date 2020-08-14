
import 'package:black_dragon_app/src/data/bloc/provider_bloc.dart';
import 'package:black_dragon_app/src/data/providers/usuario_provider.dart';
import 'package:black_dragon_app/src/models/estudiante_model.dart';
import 'package:black_dragon_app/src/pages/authenticate/login_page.dart';
import 'package:black_dragon_app/src/utils/routes/routes.dart';
import 'package:black_dragon_app/src/utils/utils.dart' as utils;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MenuPrincipal extends StatelessWidget {

  @required final model;

  const MenuPrincipal({
    this.model
  });

  @override
  Widget build(BuildContext context) {
    final _auth             = new UsuarioProvider();
    final bloc              = new ProviderBloc();

    return Drawer(
      child: Container(
        child: FutureBuilder<EstudianteModel>(
          future: model,
            builder: (context, snapshot)  { 
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    SafeArea(
                      child: Container(
                        width: double.infinity,
                        height: 180,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Image.asset('assets/img/BlackDragons.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    utils.buildHeader(snapshot, false),
                    utils.division(),
                    Expanded(
                      child: _ListOpciones()
                    ),
                    utils.division(),
                    ListTile(
                        leading: Icon(FontAwesomeIcons.signOutAlt),
                        title: Text('Cerrar sesión'),                        
                        onTap: () async {                         
                            _auth.signOut().then((res) {
                                bloc.loginBloc.changeEmail('');
                                bloc.loginBloc.changePassword('');
                                bloc.loginBloc.dispose();
                                

                                Navigator.pushReplacement(
                                context,
                                SlideRightSinOpacidadRoute(widget: LoginPage())
                                );
                            });
                        },
                      ),

                  ],
                );         
              } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(                  
                      child: CircularProgressIndicator(),
                    ),
                  ],
              );
          }
        ),
      ),
    );
  }
}

class _ListOpciones extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics:          BouncingScrollPhysics(),
      itemCount:        pageRoutes.length,
      separatorBuilder: (context, i) => utils.division(),
      itemBuilder:      (context, i) => ListTile(
        leading:        FaIcon(pageRoutes[i].icon, color: Colors.black54),
        title:          Text(pageRoutes[i].titulo),
        trailing:       Icon(Icons.chevron_right, color: Colors.black54),
        onTap: () {
                        Navigator.push(context, SlideRightRoute(widget:  pageRoutes[i].page)); 
        },
      ),        
    );
  }
}

  