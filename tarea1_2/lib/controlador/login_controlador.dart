import '../modelo/usuario_modelo.dart';

class LoginControlador {
  // Usuario de prueba registrado en la aplicación
  static const UsuarioModelo usuarioRegistrado = UsuarioModelo(
    usuario: 'admin',
    clave: '1234',
  );

  String? validarUsuario(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Ingrese su usuario';
    if (texto.contains(' ')) return 'El usuario no debe contener espacios';
    if (texto.length < 4) return 'El usuario debe tener al menos 4 caracteres';
    return null;
  }

  String? validarClave(String? valor) {
    final texto = valor ?? '';
    if (texto.isEmpty) return 'Ingrese su contraseña';
    if (texto.length < 4) {
      return 'La contraseña debe tener al menos 4 caracteres';
    }
    return null;
  }

  //metodo autenticar
  bool autenticar(UsuarioModelo usuario) {
    return usuario.usuario == usuarioRegistrado.usuario &&
        usuario.clave == usuarioRegistrado.clave;
  }
}
