import 'dart:convert';

EstudianteModel estudianteModelFromJson(String str) => EstudianteModel.fromJson(json.decode(str));

String estudianteModelToJson(EstudianteModel data) => json.encode(data.toJson());

class EstudianteModel {
    EstudianteModel({
        this.apellidos,
        this.correo,
        this.dojang,
        this.fechaNacimiento,
        this.fono,
        this.grado,
        this.intructor,
        this.metodoPago,
        this.infoMedica,
        this.motivacion,
        this.nombre,
        this.ranking,
        this.rut,
        this.imagen,
    });

    String apellidos;
    String correo;
    Dojang dojang;
    String fechaNacimiento;
    String fono;
    Grado grado;
    Intructor intructor;
    MetodoPago metodoPago;
    InfoMedica infoMedica;
    String motivacion;
    String nombre;
    int ranking;
    String rut;
    String imagen;

    factory EstudianteModel.fromJson(Map<String, dynamic> json) => EstudianteModel(
        apellidos: json["apellidos"],
        correo: json["correo"],
        dojang: Dojang.fromJson(json["dojang"]),
        fechaNacimiento: json["fechaNacimiento"],
        fono: json["fono"],
        grado: Grado.fromJson(json["grado"]),
        intructor: Intructor.fromJson(json["intructor"]),
        metodoPago: MetodoPago.fromJson(json["metodoPago"]),
        infoMedica: InfoMedica.fromJson(json["infoMedica"]),
        motivacion: json["motivacion"],
        nombre: json["nombre"],
        ranking: json["ranking"],
        rut: json["rut"],
        imagen: json["imagen"],
    );

    Map<String, dynamic> toJson() => {
        "apellidos": apellidos,
        "correo": correo,
        "dojang": dojang.toJson(),
        "fechaNacimiento": fechaNacimiento,
        "fono": fono,
        "grado": grado.toJson(),
        "intructor": intructor.toJson(),
        "metodoPago": metodoPago.toJson(),
        "infoMedica": infoMedica.toJson(),
        "motivacion": motivacion,
        "nombre": nombre,
        "ranking": ranking,
        "rut": rut,
        "imagen": imagen,
    };
}

class Dojang {
    Dojang({
        this.ciudad,
        this.direccion,
        this.escuela,
        this.instructor,
        this.sede,
    });

    String ciudad;
    String direccion;
    String escuela;
    String instructor;
    String sede;

    factory Dojang.fromJson(Map<String, dynamic> json) => Dojang(
        ciudad: json["ciudad"],
        direccion: json["direccion"],
        escuela: json["escuela"],
        instructor: json["instructor"],
        sede: json["sede"],
    );

    Map<String, dynamic> toJson() => {
        "ciudad": ciudad,
        "direccion": direccion,
        "escuela": escuela,
        "instructor": instructor,
        "sede": sede,
    };
}

class Grado {
    Grado({
        this.fechaExamen,
        this.gradoActual,
        this.notaExamen,
        this.color,
        this.nombre,
    });

    String fechaExamen;
    bool gradoActual;
    int notaExamen;
    String color;
    String nombre;

    factory Grado.fromJson(Map<String, dynamic> json) => Grado(
        fechaExamen: json["FechaExamen"],
        gradoActual: json["GradoActual"],
        notaExamen: json["NotaExamen"],
        color: json["color"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "FechaExamen": fechaExamen,
        "GradoActual": gradoActual,
        "NotaExamen": notaExamen,
        "color": color,
        "nombre": nombre,
    };
}

class InfoMedica {
    InfoMedica({
        this.nombre,
    });

    String nombre;

    factory InfoMedica.fromJson(Map<String, dynamic> json) => InfoMedica(
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
    };
}

class MetodoPago {
    MetodoPago({
        this.nombre,
    });

    String nombre;

    factory MetodoPago.fromJson(Map<String, dynamic> json) => MetodoPago(
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
    };
}

class Intructor {
    Intructor({
        this.apellido,
        this.nombre,
        this.id,
    });

    String apellido;
    String nombre;
    String id;

    factory Intructor.fromJson(Map<String, dynamic> json) => Intructor(
        apellido: json["apellido"],
        nombre: json["nombre"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "apellido": apellido,
        "nombre": nombre,
        "id": id,
    };
}
