import 'package:black_dragon_app/src/data/bloc/changePassword_bloc.dart';
import 'package:black_dragon_app/src/data/bloc/provider_bloc.dart';
import 'package:black_dragon_app/src/pages/home_page.dart';
import 'package:black_dragon_app/src/utils/routes/routes.dart';
import 'package:black_dragon_app/src/utils/utils.dart';
import 'package:flutter/material.dart';

class CambiarPasswordPage extends StatelessWidget {

  Container _fondo(Color color1, Color color2) {
    return Container(
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
    );
  }
  

  Widget _loginForm(BuildContext context) {
    final bloc = ProviderBloc.cambiarPassBloc(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Center(
            child: Container(
              width: size.width * 0.9,
              margin: EdgeInsets.symmetric(vertical: 30.0),
              padding: EdgeInsets.symmetric(vertical: 50.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0
                  )
                ]
              ),
              child: Column(
                children: <Widget>[
                  Text('Cambiar contraseña', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20.0,),
                  _inputPassword(bloc),
                   SizedBox(height: 20.0,),
                  _repetirPassword(bloc),
                   SizedBox(height: 20.0,),
                  _crearBotton(bloc)
                ],
              ),
            ),
          ),

          SizedBox(height: 100.0),
        ],
      ),
    );
  }

  Widget _inputPassword(ChangePasswordBloc bloc) {

    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.black87,),
              labelText: 'Contraseña',
              counterText: snapshot.data,
              errorText: snapshot.error,
              fillColor: Colors.pink
            ),
            onChanged: bloc.changePassword,
          ),
        );
      }
    );
  }

  Widget _repetirPassword(ChangePasswordBloc bloc) {

    return StreamBuilder(
      stream: bloc.repetirPasswordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.black87,),
              labelText: 'Repetir Contraseña',
              counterText: snapshot.data,
              errorText: snapshot.error,
              fillColor: Colors.pink
            ),
            onChanged: bloc.changerepetirPassword,
          ),
        );
      }
    );
  }

  Widget _crearBotton(ChangePasswordBloc bloc) {
      return StreamBuilder(
        stream: bloc.formValidChangePass,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Guardar'),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
            ),
            elevation: 0.0,
            color: Colors.orangeAccent,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? () => _cambiarPass(bloc, context) : null
          );
        }
      );
    }

  _cambiarPass(ChangePasswordBloc bloc, BuildContext context) async {

    Map info = await bloc.cambiarPassword(bloc.password);
    if (info['ok']) {
      showToast(context,'Contraseña guardada de forma exitosa!');
      Navigator.pushReplacement(context, SlideRightSinOpacidadRoute(widget: HomePage()));
    } else {
      showToast(context,info['mensaje']);
    }
  }


  @override
  Widget build(BuildContext context) {

    Color color1 = Color(0xfffbb034);           
    Color color2 = Color(0xffffdd00);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),              
            onPressed: () => Navigator.of(context).pop(),
          ), 
          title: Text("Cambiar Contraseña"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),

      body: Stack(
        children: <Widget>[
          _fondo(color1, color2),
          _loginForm(context),
        ],
      )
    );
  }
}