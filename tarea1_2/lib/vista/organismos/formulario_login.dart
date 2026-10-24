import 'package:flutter/material.dart';

import '../atomos/boton_principal.dart';
import '../moleculas/entrada_credenciales.dart';

class FormularioLogin extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usuarioController;
  final TextEditingController claveController;
  final FormFieldValidator<String> validarUsuario;
  final FormFieldValidator<String> validarClave;
  final VoidCallback callback;

  const FormularioLogin({
    super.key,
    required this.formKey,
    required this.usuarioController,
    required this.claveController,
    required this.validarUsuario,
    required this.validarClave,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          EntradaCredenciales(
            usuarioController: usuarioController,
            claveController: claveController,
            validarUsuario: validarUsuario,
            validarClave: validarClave,
            onEnviar: callback,
          ),
          const SizedBox(height: 24.0),
          BotonPrincipal(
            texto: 'Ingresar',
            icono: Icons.login,
            onPressed: callback,
          ),
        ],
      ),
    );
  }
}
