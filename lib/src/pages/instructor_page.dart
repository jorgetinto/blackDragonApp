import 'package:black_dragon_app/src/utils/utils.dart';
import 'package:black_dragon_app/src/utils/widget/Menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class IntructorPage extends StatelessWidget {

  Widget _header(){

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
                      Text("Rodrigo villalobos", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                      SizedBox(height: 5.0,),
                      Text("Cinturón Negro - 2° Dan", style: TextStyle(fontSize: 15.0),),
                      SizedBox(height: 5.0,),
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.map, size: 10.0, color: Colors.black54,),
                          SizedBox(height: 10.0,),
                          Text(" Sede Central", style: TextStyle(color: Colors.black54)),
                        ],
                      )
                    ],
        ),
      ],
    );
  }

  Widget _crearAcciones() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[        
        _accion(Icons.call, 'Llamar', 'tel:+56956754422'),
        _accion(FontAwesomeIcons.whatsapp, 'Mensaje', 'https://wa.me/+56956754422?text=Hello'),
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

    Color color1 = Color(0xfffbb034);           
    Color color2 = Color(0xffffdd00);

    return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),              
              onPressed: () => Navigator.of(context).pop(),
            ), 
            title: Text("Instructor"),
            backgroundColor: Colors.black,
            centerTitle: true,
          ),
          drawer: MenuPrincipal(),
          body: SingleChildScrollView(
            child: Center(
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
                          padding: const EdgeInsets.all(20.0),
                          child: CircleAvatar(                  
                                    radius: 18,
                                    child: ClipOval(
                                        child: Image.network('https://www.woolha.com/media/2020/03/eevee.png'),                                        
                                    ),
                                    backgroundColor: Colors.white,
                                ),
                        ),
                      ),
                      SizedBox(height: 30,),    
                      buildTitle('Instructor'),
                      _header(), 
                      division(),    
                      _crearAcciones()     
                    
                    ],
                  ),
                  
                ),
              ),
          ),
        )
    );
  }
}
