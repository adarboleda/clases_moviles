import '../model/usuario_modelo.dart';

class LoginControlador {
  //credenciales quemadas
  final UsuarioModelo _usuarioValido = UsuarioModelo(
    correo: 'abner@gmail.com',
    clave: '123456',
  );

  //validar formato de correo electronico
  bool correoValido(String correo) {
    return RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$').hasMatch(correo);
  }

  bool iniciarSesion(String correo, String clave) {
    return correo.toLowerCase() == _usuarioValido.correo &&
        clave == _usuarioValido.clave;
  }
}
