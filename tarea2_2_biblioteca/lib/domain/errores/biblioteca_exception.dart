//error con un mensaje que se puede mostrar al usuario
class BibliotecaException implements Exception {
  final String mensaje;

  const BibliotecaException(this.mensaje);

  @override
  String toString() => mensaje;
}

//se lanza cuando no se cumple una regla de negocio
class ReglaNegocioException extends BibliotecaException {
  const ReglaNegocioException(super.mensaje);
}
