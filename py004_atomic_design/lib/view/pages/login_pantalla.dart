import 'package:flutter/material.dart';

import '../../controller/login_controlador.dart';
import '../organisms/formulario_login.dart';
import 'numero_pantalla.dart';

class LoginPantalla extends StatefulWidget {
  const LoginPantalla({super.key});

  @override
  State<LoginPantalla> createState() => _LoginPantallaState();
}

class _LoginPantallaState extends State<LoginPantalla> {
  //mapeo de objetos
  final correo = TextEditingController();
  final clave = TextEditingController();
  //instanciacion de clases
  final controlador = LoginControlador();
  //mensajes de error de validacion
  String? errorCorreo;
  String? errorClave;

  void mostrarMensaje(String mensaje, Color color) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mensaje), backgroundColor: color));
  }

  //metodo iniciar sesion
  void iniciarSesion() {
    String textoCorreo = correo.text.trim();
    //validar que ambos campos tengan informacion
    setState(() {
      if (textoCorreo.isEmpty) {
        errorCorreo = 'Ingrese su correo electrónico';
      } else if (!controlador.correoValido(textoCorreo)) {
        errorCorreo = 'Ingrese un correo electrónico válido';
      } else {
        errorCorreo = null;
      }
      errorClave = clave.text.isEmpty ? 'Ingrese su contraseña' : null;
    });
    if (errorCorreo != null || errorClave != null) return;

    if (controlador.iniciarSesion(textoCorreo, clave.text)) {
      mostrarMensaje('Bienvenido $textoCorreo', Colors.green);
      limpiar();
      //ir a la pantalla de numeros
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NumerosPantalla()),
      );
    } else {
      mostrarMensaje('Correo o contraseña incorrectos', Colors.red);
    }
  }

  //limpiar
  void limpiar() {
    setState(() {
      correo.clear();
      clave.clear();
      errorCorreo = null;
      errorClave = null;
    });
  }

  @override
  void dispose() {
    correo.dispose();
    clave.dispose();
    super.dispose();
  }

  /*diseño de la pantalla de login*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: FormularioLogin(
              correo: correo,
              clave: clave,
              errorCorreo: errorCorreo,
              errorClave: errorClave,
              onLogin: iniciarSesion,
              onLimpiar: limpiar,
            ),
          ),
        ),
      ),
    );
  }
}
