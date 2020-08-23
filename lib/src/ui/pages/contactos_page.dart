import 'package:black_dragon_app/src/data/bloc/contactos_bloc.dart';
import 'package:black_dragon_app/src/data/bloc/provider_bloc.dart';
import 'package:black_dragon_app/src/data/models/contactos_model.dart';
import 'package:black_dragon_app/src/ui/pages/contacto_page.dart';
import 'package:black_dragon_app/src/ui/utils/widget/Menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactsPage extends StatelessWidget {

@override
Widget build(BuildContext context) {

  final contactosBloc = ProviderBloc.contactosBloc(context);
  contactosBloc.buscarContactos();

    return new Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),              
            onPressed: () => Navigator.of(context).pop(),
          ), 
          title: Text("Contactos"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        drawer: MenuPrincipal(),
        body: _crearListado(contactosBloc),
    );
  }

  Widget _crearListado(ContactosBloc contactosBloc) {
    return StreamBuilder(
        stream: contactosBloc.contactosStream,
        builder: (BuildContext context, AsyncSnapshot<List<ContactosModel>> snapshot) {
            if (snapshot.hasData){
              final contactos = snapshot.data;              
              return ListView.builder(
                itemCount: contactos.length,
                itemBuilder: (context, i) => _crearItem(context, contactos[i], contactosBloc)
              );
            } else {
              return Center(child: CircularProgressIndicator(),);
            }
        }
      );
  }

  Widget _crearItem(
    BuildContext context, 
    ContactosModel contactos,
    ContactosBloc contactosBloc
    ) {
    return Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.red,
          ),
          child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: new CircleAvatar(child: new Text('${contactos.nombre[0]}${contactos.apellido[0]}')),
                  title: Text('${contactos.nombre} ${contactos.apellido}'),
                  subtitle: Text('sede: ${contactos.sede} - Fono: ${contactos.fono}'),
                  trailing: IconButton(icon: Icon(FontAwesomeIcons.chevronRight, color: Colors.black87, size: 15.0),
                                    onPressed: () { 

                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => ContactoPage(),
                                                          settings: RouteSettings(
                                                            arguments: contactos
                                                          ),
                                                        ),
                                                      );
                                    },
                                  ),
                  //onTap: () => Navigator.pushNamed(context, 'producto', arguments: producto),
                ),
              ],
            ),
          )
        );
  }
}

 