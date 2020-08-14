import 'package:black_dragon_app/src/models/estudiante_model.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  Widget buildHeader(AsyncSnapshot<EstudianteModel> snapshot, bool tipoFoto){

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
      ],
    );
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



