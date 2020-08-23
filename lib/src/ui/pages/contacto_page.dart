import 'package:black_dragon_app/src/data/bloc/contactos_bloc.dart';
import 'package:black_dragon_app/src/data/bloc/provider_bloc.dart';
import 'package:black_dragon_app/src/data/models/contactos_model.dart';
import 'package:black_dragon_app/src/data/models/estudiante_model.dart';
import 'package:black_dragon_app/src/ui/utils/utils.dart';
import 'package:black_dragon_app/src/ui/utils/widget/Menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ContactoPage extends StatelessWidget {

  Widget _header(AsyncSnapshot<EstudianteModel> snapshot){

    return Row(
    children: [
        SizedBox(width: 20.0,),

        Container(
          width: 60.0,
          height: 60.0,
          child: CircleAvatar(
            radius: 30.0,
            child: Image.asset('assets/img/BlackDragons.png'),
            backgroundColor: Colors.white,
          ),
        ),

        SizedBox(width: 20.0,),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                      Text("${snapshot.data.nombre} ${snapshot.data.apellidos}", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                      SizedBox(height: 5.0,),
                      Text("Cinturón - ${snapshot.data.grado.color}", style: TextStyle(fontSize: 15.0),),
                      SizedBox(height: 5.0,),
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.map, size: 10.0, color: Colors.black54,),
                          SizedBox(height: 10.0,),
                          Text(" Sede ${snapshot.data.dojang.sede}", style: TextStyle(color: Colors.black54)),
                        ],
                      )
                    ],
        ),
      ],
    );
  }

  Widget _crearAcciones(AsyncSnapshot<EstudianteModel> snapshot) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[        
        _accion(Icons.call, 'Llamar', 'tel:${snapshot.data.fono}'),
        _accion(FontAwesomeIcons.whatsapp, 'Mensaje', 'https://wa.me/${snapshot.data.fono}?text=Hola'),
     ], 
    );

  }

  Widget _accion(IconData icon, String texto, String url) {
    return  Column(
            children: <Widget>[
              Container(
                  child: new IconButton(
                            icon: Icon(icon, color: Colors.black87, size: 25.0),
                            onPressed: () { launchURL(url);},
                          ),
              ),
              Text(texto, style: TextStyle( fontSize: 12.0, color: Colors.black54),),
              SizedBox(height: 10,)
            ],
          );
  }

  @override
  Widget build(BuildContext context) {

    final estudianteBloc = ProviderBloc.estudianteBloc(context);
    final ContactosModel contactosModel = ModalRoute.of(context).settings.arguments;
    estudianteBloc.buscarEstudiantebyId(contactosModel.id);

    Color color1 = Color(0xfffbb034);           
    Color color2 = Color(0xffffdd00);

    return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),              
              onPressed: () => Navigator.of(context).pop(),
            ), 
            title: Text("Contacto"),
            backgroundColor: Colors.black,
            centerTitle: true,
          ),
          drawer: MenuPrincipal(),
          body: SingleChildScrollView(
            
            child: StreamBuilder<EstudianteModel>(
              stream: estudianteBloc.estudianteByIdStream,
              builder: (context, snapshot) {
                 if (snapshot.hasData) {

                  return Center(
                              child: Container(
                              width: double.infinity,
                              height: 500,
                              child: Card(         
                                  color: Colors.white,
                                  elevation: 10,
                                  child: Column(
                                    children: <Widget>[

                                      Container(
                                        width: double.infinity,
                                        height: 250,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomRight:  Radius.circular(100)
                                            ),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: <Color>[
                                              color1,
                                              color2,
                                            ]
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(40.0),
                                          child: CircleAvatar(                  
                                                  radius: 20,
                                                  child: ClipOval(
                                                      child: Container( child: Image.network('${snapshot.data.imagen}')),                                        
                                                  ),
                                                  backgroundColor: Colors.white,
                                                ),
                                        ),
                                      ),
                                      SizedBox(height: 30,),    
                                      buildTitle('Contacto'),
                                      _header(snapshot), 
                                      division(),    
                                      _crearAcciones(snapshot)     
                                    
                                    ],
                                  ),
                                  
                                ),
                              ),
                        );

                 } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 200.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  ),
                );
              }
            ),
        )
    );
  }
}
