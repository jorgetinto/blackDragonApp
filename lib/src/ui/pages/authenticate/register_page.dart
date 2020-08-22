import 'package:black_dragon_app/src/data/bloc/login_bloc.dart';
import 'package:black_dragon_app/src/data/bloc/provider_bloc.dart';
import 'package:black_dragon_app/src/ui/pages/authenticate/login_page.dart';
import 'package:black_dragon_app/src/ui/pages/home_page.dart';
import 'package:black_dragon_app/src/ui/utils/routes/routes.dart';
import 'package:black_dragon_app/src/ui/utils/utils.dart';
import 'package:black_dragon_app/src/ui/utils/widget/Header_widget.dart';

import 'package:flutter/material.dart';


class RegisterPage extends StatelessWidget {

  Widget _crearFondo(BuildContext context) {

    return Stack(
      children: <Widget>[
        HeaderWaveGradient(),       
          Container(
            padding: EdgeInsets.only(top: 40.0),
            child: Column(
              children: <Widget>[
                Container(
                    width: double.infinity,
                    height: 180,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset('assets/img/BlackDragons.png'),
                    ),
                  ),
              ],
            ),
          )
      ],
    );
  }

  Widget _registerForm(BuildContext context) {
    final bloc = ProviderBloc.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(child: Container(height: 170.0,)),
          Container(
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
                Text('Registrar Usuario', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                SizedBox(height: 20.0,),
                _crearEmail(bloc),
                 SizedBox(height: 20.0,),
                _crearPassword(bloc),
                 SizedBox(height: 20.0,),
                _crearBotton(bloc)
              ],
            ),
          ),

         FlatButton(
            onPressed: () => Navigator.pushReplacement(context, SlideRightSinOpacidadRoute(widget: LoginPage()) ),
            child: Text('Iniciar sesión', 
                                        style: TextStyle(
                                        decoration:
                                            TextDecoration.underline,
                                        height: 1.5,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto-Regular',
                                      ),            
            )),
          SizedBox(height: 100.0),
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.black87,),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electrónico',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      }      
    );
  }

  Widget _crearPassword(LoginBloc bloc) {

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

  Widget _crearBotton(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Registrar'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          color: Colors.orangeAccent,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _register(bloc, context) : null
        );
      }
    );
  }

  _register(LoginBloc bloc, BuildContext context) async {
    Map info = await bloc.registerWithEmailAnfPassword(bloc.email, bloc.password);
    if (info['ok']) {
      Navigator.pushReplacement(context, SlideRightSinOpacidadRoute(widget: HomePage()));
    } else {
      showToast(context,info['mensaje']);
    } 
  }

  @override
 Widget build(BuildContext context) {
    return Scaffold(
    body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _registerForm(context),
      ],
    )
    );
  }
}