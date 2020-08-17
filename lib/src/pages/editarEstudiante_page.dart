import 'package:flutter/material.dart';

class EditarEstudiantePage extends StatefulWidget {
  @override
  _EditarEstudiantePageState createState() => _EditarEstudiantePageState();
}

class _EditarEstudiantePageState extends State<EditarEstudiantePage> {

  final formKey           = GlobalKey<FormState>();
  final scaffoldKey       = GlobalKey<ScaffoldState>();

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text('Editar Información'),
      backgroundColor: Colors.black,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.photo_size_select_actual),
          onPressed: () {},
        ),
        IconButton(icon: Icon(Icons.camera_alt), onPressed: () {})
      ],
    );
  }

  Widget _mostrarFoto() {

      // if (producto.fotoUrl != null) {

      //   return FadeInImage(
      //     placeholder: AssetImage('assets/jar-loading.gif'), 
      //     image: NetworkImage(producto.fotoUrl),
      //     height: 300.0,
      //     fit: BoxFit.contain,
      //     );

      // } else {

      //     if( foto != null ){
      //       return Image.file(
      //         foto,
      //         fit: BoxFit.cover,
      //         height: 300.0,
      //       );
      //   }
        
        return Image.asset('assets/no-image.png'); 
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto()
              ],
            )
          ),
        ),
      ),
    );
  }

  
}
