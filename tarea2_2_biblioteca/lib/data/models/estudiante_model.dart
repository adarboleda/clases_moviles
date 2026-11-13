import '../../domain/entities/estudiante.dart';

class EstudianteModel extends Estudiante {
  EstudianteModel({
    required super.id,
    required super.cedula,
    required super.nombre,
    required super.carrera,
    required super.correo,
  });

  factory EstudianteModel.desdeEntidad(Estudiante estudiante) {
    return EstudianteModel(
      id: estudiante.id,
      cedula: estudiante.cedula,
      nombre: estudiante.nombre,
      carrera: estudiante.carrera,
      correo: estudiante.correo,
    );
  }

  //metodo factory
  factory EstudianteModel.fromJson(Map<String, dynamic> json) {
    return EstudianteModel(
      id: json['id'],
      cedula: json['cedula'] ?? '',
      nombre: json['nombre'] ?? '',
      carrera: json['carrera'] ?? '',
      correo: json['correo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cedula': cedula,
      'nombre': nombre,
      'carrera': carrera,
      'correo': correo,
    };
  }
}
