import 'package:black_dragon_app/src/models/estudiante_model.dart';
import 'package:black_dragon_app/src/pages/editarEstudiante_page.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

  Widget division() {
    return Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[          
              Divider(
                color: Colors.black54,
              ),
            ],
          ),
        );
  }

  Widget buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Divider(
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context, AsyncSnapshot<EstudianteModel> snapshot, bool tipoFoto){

  return Row(
    children: [
        SizedBox(width: 20.0,),

        Container(
          width: 60.0,
          height: 60.0,
          child: CircleAvatar(
            radius: 30.0,
            child: (tipoFoto) ? Image.asset('assets/img/BlackDragons.png') 
                              : ClipOval(child: Container(child: Image.network(snapshot.data.imagen))),
            backgroundColor: Colors.white,
          ),
        ),

        SizedBox(width: 20.0,),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                      Text("${snapshot.data.nombre} ${snapshot.data.apellidos}", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),
                      SizedBox(height: 5.0,),
                      Text("${snapshot.data.rut}", style: TextStyle(fontSize: 13.0),),
                      SizedBox(height: 5.0,),
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.map, size: 10.0, color: Colors.black54,),
                          SizedBox(height: 10.0,),
                          Text("Santiago", style: TextStyle(color: Colors.black54)),
                        ],
                      )
                    ],
        ),
        
        _iconoEditar(tipoFoto, context, snapshot),
      ],
    );
  }

  Column _iconoEditar(bool tipoFoto, BuildContext context, AsyncSnapshot<EstudianteModel> snapshot) {
    return (!tipoFoto) ? Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [ 
          SizedBox(height: 30.0,),
          IconButton(
              icon: FaIcon(FontAwesomeIcons.edit, size: 20.0, color: Colors.black,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditarEstudiantePage(),
                    settings: RouteSettings(
                      arguments: snapshot.data,
                    ),
                  ),
                );      
              },
            ),
        ],
      ): Column();
  }

  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
}

  void showToast(BuildContext context, String msg) {
    Toast.show( msg, context, duration: 2, gravity: Toast.BOTTOM);
  }

  calculateAge(String strDt) {
    var birth = Jiffy(strDt, "dd/MM/yyyy").format("yyyy-MM-dd"); // 2019-08-18
      DateTime birthDate = DateTime.parse(birth);
      DateTime currentDate = DateTime.now();
      int age = currentDate.year - birthDate.year;
      int month1 = currentDate.month;
      int month2 = birthDate.month;

      if (month2 > month1) {
        age--;
      } else if (month1 == month2) {
        int day1 = currentDate.day;
        int day2 = birthDate.day;
        if (day2 > day1) {
          age--;
        }
      }
      return age.toString();
  }


