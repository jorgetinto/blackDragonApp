
import 'package:black_dragon_app/src/data/bloc/provider_bloc.dart';
import 'package:black_dragon_app/src/models/estudiante_model.dart';
import 'package:black_dragon_app/src/pages/authenticate/login_page.dart';
import 'package:black_dragon_app/src/utils/routes/routes.dart';
import 'package:black_dragon_app/src/utils/utils.dart' as utils;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MenuPrincipal extends StatefulWidget {

  @required final Stream<EstudianteModel> model;  

  const MenuPrincipal({
    this.model
  });

  @override
  _MenuPrincipalState createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  @override
  Widget build(BuildContext context) {
    final estudianteBloc    = ProviderBloc.estudianteBloc(context);
    final usuarioProvider   = ProviderBloc.of(context);

    if (widget.model == null){
      estudianteBloc.buscarEstudiante();
    }  

    return Drawer(
      child: Container(
        child: StreamBuilder<EstudianteModel>(
          stream: widget.model ?? estudianteBloc.estudianteStream,
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
                    utils.buildHeader(context,snapshot, false),
                    utils.division(),
                    Expanded(
                      child: _ListOpciones()
                    ),
                    utils.division(),
                    ListTile(
                        leading: Icon(FontAwesomeIcons.signOutAlt),
                        title: Text('Cerrar sesión'),                        
                        onTap: () async {                      
                            usuarioProvider.signOut().then((res) {
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

  