import 'dart:convert';

ContactosModel contactosModelFromJson(String str) => ContactosModel.fromJson(json.decode(str));

String contactosModelToJson(ContactosModel data) => json.encode(data.toJson());

class ContactosModel {
    ContactosModel({
        this.id,
        this.apellido,
        this.nombre,
        this.fono,
        this.sede,
    });

    String id;
    String apellido;
    String nombre;
    String fono;
    String sede;

    factory ContactosModel.fromJson(Map<String, dynamic> json) => ContactosModel(
        id: json["id"],
        apellido: json["apellido"],
        nombre: json["nombre"],
        fono: json["fono"],
        sede: json["sede"],
    );

    Map<String, dynamic> toJson() => {
        "apellido": apellido,
        "nombre": nombre,
        "fono": fono,
        "sede": sede,
    };
}
