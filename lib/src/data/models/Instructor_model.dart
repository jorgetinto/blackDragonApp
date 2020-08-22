import 'dart:convert';

InstructorModel instructorModelFromJson(String str) => InstructorModel.fromJson(json.decode(str));

String instructorModelToJson(InstructorModel data) => json.encode(data.toJson());

class InstructorModel {
    InstructorModel({
        this.apellido,
        this.correo,
        this.fono,
        this.grado,
        this.nombre,
        this.imagen,
    });

    String apellido;
    String correo;
    String fono;
    String grado;
    String nombre;
    String imagen;

    factory InstructorModel.fromJson(Map<String, dynamic> json) => InstructorModel(
        apellido: json["apellido"],
        correo: json["correo"],
        fono: json["fono"],
        grado: json["grado"],
        nombre: json["nombre"],
        imagen: json["imagen"],
    );

    Map<String, dynamic> toJson() => {
        "apellido": apellido,
        "correo": correo,
        "fono": fono,
        "grado": grado,
        "nombre": nombre,
        "imagen": imagen,
    };
}
