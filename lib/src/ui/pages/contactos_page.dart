import 'package:black_dragon_app/src/data/bloc/contactos_bloc.dart';
import 'package:black_dragon_app/src/data/bloc/provider_bloc.dart';
import 'package:black_dragon_app/src/data/models/contactos_model.dart';
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
                  subtitle: Text('${contactos.nombreGrado} - ${contactos.colorGrado}'),
                  trailing: IconButton(icon: Icon(FontAwesomeIcons.chevronRight, color: Colors.black87, size: 15.0),
                                    onPressed: () { 
                                      // if (page != null){edkmjededededededededjedjedjedjedjedjje
                                      //   Navigator.push(context, router.SlideRightRoute(widget: page)); 
                                      // }                              
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

  // class _ListOpciones extends StatelessWidget {

  //   @override
  //   Widget build(BuildContext context) {
  //     return ListView.separated(
  //       physics:          BouncingScrollPhysics(),
  //       itemCount:        pageRoutes.length,
  //       separatorBuilder: (context, i) => utils.division(),
  //       itemBuilder:      (context, i) => ListTile(
  //           leading:        FaIcon(pageRoutes[i].icon, color: Colors.black54),
  //           title:          Text(pageRoutes[i].titulo),
  //           trailing:       Icon(Icons.chevron_right, color: Colors.black54),
  //           onTap: () {
  //                           Navigator.push(context, SlideRightRoute(widget:  pageRoutes[i].page)); 
  //           },
  //       ),        
  //     );
  //   }
  // }

    // const kContacts = const <Contact>[
    //   const Contact(fullName: 'Romain Hoogmoed', email: 'romain.hoogmoed@example.com'),
    //   const Contact(fullName: 'Emilie Olsen', email: 'emilie.olsen@example.com')
    // ];

    // class ContactList extends StatelessWidget {
    //   final List<Contact> _contacts;

    //   ContactList(this._contacts);

    //   @override
    //   Widget build(BuildContext context) {
    //     return new ListView.builder(
    //       padding: new EdgeInsets.symmetric(vertical: 8.0),
    //       itemBuilder: (context, index) {
    //         return new _ContactListItem(_contacts[index]);
    //       },
    //       itemCount: _contacts.length,
    //     );
    //   }
    // }

    // class _ContactListItem extends ListTile {
    //   _ContactListItem(Contact contact)
    //       : super(
    //             title: new Text(contact.fullName),
    //             subtitle: new Text(contact.email),
    //             leading: new CircleAvatar(child: new Text(contact.fullName[0])),
    //             trailing: IconButton(icon: Icon(FontAwesomeIcons.chevronRight, color: Colors.black87, size: 15.0),
    //                               onPressed: () { 
    //                                 // if (page != null){
    //                                 //   Navigator.push(context, router.SlideRightRoute(widget: page)); 
    //                                 // }                              
    //                               },
    //                             ),
    //       );
    // }

    // class Contact {
    //   final String fullName;
    //   final String email;

    //   const Contact({this.fullName, this.email});
    // }

  