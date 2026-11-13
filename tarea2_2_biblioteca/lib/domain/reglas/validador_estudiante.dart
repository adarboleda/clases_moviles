import '../entities/estudiante.dart';

//validaciones de los datos de un estudiante
//se usan en el formulario y en el caso de uso RegistrarEstudiante
class ValidadorEstudiante {
  static String? cedula(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Ingrese la cédula';
    if (!RegExp(r'^\d{10}$').hasMatch(texto)) {
      return 'La cédula debe tener 10 dígitos';
    }
    return null;
  }

  static String? nombre(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Ingrese el nombre';
    if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]+$').hasMatch(texto)) {
      return 'Solo se permiten letras y espacios';
    }
    if (texto.length < 3) return 'El nombre es demasiado corto';
    return null;
  }

  static String? carrera(String? valor) {
    if ((valor?.trim() ?? '').isEmpty) return 'Seleccione la carrera';
    return null;
  }

  static String? correo(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Ingrese el correo';
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(texto)) {
      return 'El correo no es válido';
    }
    return null;
  }

  //primer error encontrado o null si el estudiante es valido
  static String? validar(Estudiante estudiante) {
    return cedula(estudiante.cedula) ??
        nombre(estudiante.nombre) ??
        carrera(estudiante.carrera) ??
        correo(estudiante.correo);
  }
}
