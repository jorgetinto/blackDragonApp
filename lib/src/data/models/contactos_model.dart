import 'dart:convert';

ContactosModel contactosModelFromJson(String str) => ContactosModel.fromJson(json.decode(str));

String contactosModelToJson(ContactosModel data) => json.encode(data.toJson());

class ContactosModel {
    ContactosModel({
        this.id,
        this.colorGrado,
        this.apellido,
        this.nombreGrado,
        this.nombre,
    });

    String id;
    String colorGrado;
    String apellido;
    String nombreGrado;
    String nombre;

    factory ContactosModel.fromJson(Map<String, dynamic> json) => ContactosModel(
        id: json["id"],
        colorGrado: json["colorGrado"],
        apellido: json["apellido"],
        nombreGrado: json["nombreGrado"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "colorGrado": colorGrado,
        "apellido": apellido,
        "nombreGrado": nombreGrado,
        "nombre": nombre,
    };
}
