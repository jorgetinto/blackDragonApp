import 'package:black_dragon_app/src/data/bloc/provider_bloc.dart';
import 'package:black_dragon_app/src/models/estudiante_model.dart';
import 'package:black_dragon_app/src/pages/instructor_page.dart';
import 'package:black_dragon_app/src/utils/routes/routes.dart' as router;
import 'package:black_dragon_app/src/utils/utils.dart' as utils;
import 'package:black_dragon_app/src/utils/widget/Menu_widget.dart';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HomePage extends StatefulWidget {  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {    
    
    final estudianteBloc = ProviderBloc.estudianteBloc(context);
    estudianteBloc.buscarEstudiante();

    ListTile _buildExperienceRow({ String company, String position, String duration, IconData icono, Widget page}) {

      String dura = (duration != "") ? '($duration)' : '';

      return ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 20.0),
          child: Icon(
            (icono == null ? FontAwesomeIcons.solidCircle : icono),
            size: 20.0,
            color: Colors.black54,
          ),
        ),
        title: Text(
          company,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Text("$position $dura"),
        trailing: Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 20.0),
          child: IconButton(icon: Icon(FontAwesomeIcons.chevronRight, color: Colors.black87, size: 20.0),
                            onPressed: () { 
                              if (page != null){
                                Navigator.push(context, router.SlideRightRoute(widget: page)); 
                              }                              
                            },
                          ),
        ),
      );
    }

    Widget _crearBottomNavigationBar() {
      return BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidUserCircle),
            title: Text('Credencial')
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.users),
            title: Text('Contactos')
          ),
        ]
      );
    }

    Widget _footer(AsyncSnapshot<EstudianteModel> snapshot) {
        return Column(
          children: [

              SizedBox(height: 20.0),          
              utils.buildTitle("Contacto"),          
              SizedBox(height: 5.0),
              Row(
                  children: <Widget>[
                    SizedBox(width: 30.0),
                    Icon(
                      Icons.mail,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "${snapshot.data.correo}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    SizedBox(width: 30.0),
                    Icon(
                      Icons.phone,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "${snapshot.data.fono}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
          ],
        );
      }

    Widget _iconoRanking(AsyncSnapshot<EstudianteModel> snapshot) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FadeInLeft(
              from: 20,
              child: Column(
                children: [
                  Icon(Icons.star, color: Color(0xffffdd00)),
                  Text('Ranking:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${snapshot.data.ranking}'),
                ],
              ),
            ),
            FadeInLeft(
              from: 20,
              child: Column(
                children: [
                  Icon(Icons.star, color: Color(0xffffdd00)),
                  Text('Grado:', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('${snapshot.data.grado.nombre}'),
                ],
              ),
            ),

            FadeInLeft(
              from: 20,
              child: Column(
                children: [
                  Icon(Icons.star, color: Color(0xffffdd00)),
                  Text('Edad:', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('${snapshot.data.edad}'),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _dojang(AsyncSnapshot<EstudianteModel> snapshot){
      return Container(
        child: Column(
          children: [

              SizedBox(height: 20.0),

              utils.buildTitle("Dojang"),
              
              SizedBox(height: 5.0),

              _buildExperienceRow(
                  company: "${snapshot.data.dojang.escuela}",
                  position: "${snapshot.data.dojang.direccion}",
                  duration: "${snapshot.data.dojang.sede}",
                ),   

              _buildExperienceRow(
                  company: "Instructor",
                  position: "${snapshot.data.intructor.nombre} ${snapshot.data.intructor.apellido}",
                  duration: "${snapshot.data.intructor.grado}",
                  page: IntructorPage()),

              _buildExperienceRow(
                  company: "Forma de Pago",
                  position: "Efectivo",
                  duration: "",
                  icono: FontAwesomeIcons.moneyBill,
               ), 

          ],
        ),
      );
    }

    Widget _informacionMedica(AsyncSnapshot<EstudianteModel> snapshot) {
      return Container(
        child: Column(
          children: [

              SizedBox(height: 20.0),
              utils.buildTitle("Información Médica"),
              SizedBox(height: 5.0),

              _buildExperienceRow(
                  company: "Sin información",
                  position: "",
                  duration: "",
                  icono: FontAwesomeIcons.vial,
                 ), 
              

          ],
        ),
      );
    }

    Widget _gradoActual(AsyncSnapshot<EstudianteModel> snapshot) {
      return Container(
        child: Column(
          children: [

            SizedBox(height: 20.0),
              utils.buildTitle("Grado Actual"),
              SizedBox(height: 5.0),

              _buildExperienceRow(
                  company: "${snapshot.data.grado.color}",
                  position: "${snapshot.data.grado.fechaExamen}",
                  duration: "Nota: ${snapshot.data.grado.notaExamen}",
                 ), 
          ],
        ),
      );
    }

    Widget _motivacion(AsyncSnapshot<EstudianteModel> snapshot) {
      return Container(
        child: Column(
          children: [
            Container(              
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(color: Colors.grey.shade200),
                
                  child: Text(
                      "PLaboris deserunt cupidatat nostrud quis elit in Lorem veniam enim mollit sit duis tempor in. Nulla laboris ex anim ex aliqua ex elit laboris excepteur cillum occaecat nisi. Sit proident sunt labore minim nulla sunt reprehenderit ea dolore non aute.",
                      textAlign: TextAlign.justify),
                ),
          ],
        ),
      );
    }

    Widget _crearImagen(AsyncSnapshot<EstudianteModel> snapshot) {

      Color color1 = Color(0xfffbb034);           
      Color color2 = Color(0xffffdd00);

        return  Container(
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
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(  
                      backgroundColor: Colors.black,                
                      radius: 18,
                      child: ClipOval(
                          child: Image.network(snapshot.data.imagen),
                      ),
                  ),
          ),
        );
      }

    return Scaffold(
      appBar: AppBar(
        title: Text('Credencial'),
        backgroundColor: Colors.black87,
      ),
      drawer: MenuPrincipal(model: estudianteBloc.estudianteStream),

      body: SingleChildScrollView(
        child: StreamBuilder<EstudianteModel>(
          stream: estudianteBloc.estudianteStream,
            builder: (context, snapshot) {

              if (snapshot.hasData) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[            
                          _crearImagen(snapshot),
                          SizedBox(height: 10.0,),
                          utils.buildHeader(snapshot, true),
                          utils.division(),
                          _iconoRanking(snapshot),
                          utils.division(),
                          _motivacion(snapshot),  
                          _dojang(snapshot),
                          _gradoActual(snapshot),  
                          _informacionMedica(snapshot),
                          _footer(snapshot),
                          SizedBox(height: 30.0),
                      ],
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
            },
          ),
      ),
      bottomNavigationBar: _crearBottomNavigationBar()
    );
  }
}

