import 'dart:io';

import 'package:black_dragon_app/src/data/bloc/estudiante_bloc.dart';
import 'package:black_dragon_app/src/data/bloc/provider_bloc.dart';
import 'package:black_dragon_app/src/models/estudiante_model.dart';
import 'package:black_dragon_app/src/pages/home_page.dart';
import 'package:black_dragon_app/src/utils/routes/routes.dart';
import 'package:black_dragon_app/src/utils/widget/RutHelper_widget.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';


class EditarEstudiantePage extends StatefulWidget {
  @override
  _EditarEstudiantePageState createState() => _EditarEstudiantePageState();
}

class _EditarEstudiantePageState extends State<EditarEstudiantePage> {
 
  File foto;
  EstudianteBloc estudianteBloc;
  EstudianteModel estudianteModel = new EstudianteModel();
  final formKey                   = GlobalKey<FormState>();
  final scaffoldKey               = GlobalKey<ScaffoldState>();
  
  
  @override
  Widget build(BuildContext context) {
    
    estudianteBloc    = ProviderBloc.estudianteBloc(context);

    final EstudianteModel estudianteData = ModalRoute.of(context).settings.arguments;

    if (estudianteData != null) {
      estudianteModel = estudianteData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding:  EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Center(child: _mostrarFoto()),
                  _inputNombre(),                  
                  _inputApellido(),
                  _inputRut(),
                  _inputFechaNacimiento(),
                  _inputMotivacion(),
                  _inputInformacionMedica(),
                  _crearBoton(),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }  

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
          onPressed: _seleccionarFoto,
        ),
        IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: _tomarFoto
        )
      ],
    );
  }

  Widget _inputNombre() {
    return TextFormField(
      initialValue: estudianteModel.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre'
      ),
      onSaved: (value) => estudianteModel.nombre = value,
      validator: (value){
        if (value == null) {
          return 'Campo requerido';
        } else {
          return null;
        }
      },
    );
  }

  Widget _inputApellido() {
    return TextFormField(
      initialValue: estudianteModel.apellidos,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Apellidos'
      ),
      onSaved: (value) => estudianteModel.apellidos = value,
      validator: (value){
        if (value == null) {
          return 'Campo requerido';
        } else {
          return null;
        }
      },
    );
  }

  Widget _inputRut() {
    return TextFormField(
      initialValue: estudianteModel.rut,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Rut'
      ),
      onSaved: (value) => estudianteModel.rut = value,
      validator: (value){

        RutHelper rutHelp = new RutHelper();

        if (value.isEmpty || value == null) {
          return 'Campo requerido';
        } else {

          if (rutHelp.check(value)){
            return null;
          } else {
            return 'Rut Invalido';
          }          
        }
      },
    );
  }

  Widget _inputFechaNacimiento() {

      var birth = Jiffy(estudianteModel.fechaNacimiento, "dd/MM/yyyy").format("yyyy-MM-dd"); // 2019-08-18
      DateTime selectedDate = DateTime.parse(birth);

      return DateTimeField(
            label: 'Fecha de nacimiento',  
            mode: DateFieldPickerMode.date,
            dateFormat: DateFormat("dd/MM/yyyy"),            
            selectedDate: selectedDate,
            onDateSelected: (DateTime date) {
              setState(() {
                estudianteModel.fechaNacimiento = Jiffy(date.toString()).format("dd/MM/yyyy");
            });
          },
        lastDate: DateTime(2020),
      );
  }

  Widget _inputMotivacion() {
    return TextFormField(
      initialValue: estudianteModel.motivacion,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      maxLength: 500,
      decoration: InputDecoration(
        labelText: '¿Cual es tu motivación por entrenar?'
      ),
      onSaved: (value) => estudianteModel.motivacion = value,
      validator: (value){
        if (value.isEmpty || value == null) {
          return 'Campo requerido';
        } else {
          return null;
        }
      },
    );
  }

  Widget _inputInformacionMedica() {
    return TextFormField(
      initialValue: estudianteModel.infoMedica.nombre,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      maxLength: 500,
      decoration: InputDecoration(
        labelText: 'Información médica'
      ),
      onSaved: (value) => estudianteModel.infoMedica.nombre = value,
      validator: (value){
        if (value.isEmpty || value == null) {
          return 'Campo requerido';
        } else {
          return null;
        }
      },
    );
  }

  Widget _mostrarFoto() {

      if (estudianteModel.imagen != null) {

        return FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'), 
          image: NetworkImage(estudianteModel.imagen),
          height: 300.0,
          fit: BoxFit.contain,
          );

      } else {

          if( foto != null ){
            return Image.file(
              foto,
              fit: BoxFit.cover,
              height: 300.0,
            );
        }
        
        return Image.asset('assets/no-image.png'); 
      }
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: () =>  _submit(),
      );  
  }
  
  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origin) async {
      final _picker = ImagePicker();
      PickedFile pickedFile = await _picker.getImage(source: origin);      
      foto = File(pickedFile.path);  
      if (foto != null) {
        estudianteModel.imagen = null;
      }  
      setState(() {});
  }

  void _submit() async {
     if (!formKey.currentState.validate()) {
       return;
     }else {
        scaffoldKey.currentState.showSnackBar(
          new SnackBar(duration: new Duration(seconds: 20), content:
            new Row(
              children: <Widget>[
                new CircularProgressIndicator(),
                new Text("    Guardando cambios...")
              ],
            ),
          )
        );

        formKey.currentState.save();

        if (foto != null) {
            estudianteModel.imagen = await estudianteBloc.subirFoto(foto);
        }   

        estudianteBloc.editarProducto(estudianteModel);

        setState(() {
          Navigator.push(context, SlideRightRoute(widget: HomePage()));
        });
     }
  }
}
