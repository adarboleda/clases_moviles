import 'package:flutter/material.dart';

import '../../controlador/login_controlador.dart';
import '../../modelo/usuario_modelo.dart';
import '../atomos/texto_seccion.dart';
import '../moleculas/encabezado_app.dart';
import '../organismos/formulario_login.dart';

class LoginPantalla extends StatefulWidget {
  const LoginPantalla({super.key});

  @override
  State<LoginPantalla> createState() => _LoginPantallaState();
}

class _LoginPantallaState extends State<LoginPantalla> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController claveController = TextEditingController();
  final LoginControlador controlador = LoginControlador();

  void ingresar() {
    if (!formKey.currentState!.validate()) return;

    final usuario = UsuarioModelo(
      usuario: usuarioController.text.trim(),
      clave: claveController.text,
    );

    if (controlador.autenticar(usuario)) {
      //paso de parametros
      Navigator.pushReplacementNamed(
        context,
        '/consumo',
        arguments: usuario.usuario,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    }
  }

  @override
  void dispose() {
    usuarioController.dispose();
    claveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                children: [
                  const EncabezadoApp(
                    titulo: 'AquaPago',
                    subtitulo: 'Pago del servicio de agua potable',
                  ),
                  const SizedBox(height: 32.0),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextoSeccion(texto: 'Iniciar sesión'),
                          FormularioLogin(
                            formKey: formKey,
                            usuarioController: usuarioController,
                            claveController: claveController,
                            validarUsuario: controlador.validarUsuario,
                            validarClave: controlador.validarClave,
                            callback: ingresar,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Usuario de prueba: admin  •  Contraseña: 1234',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
