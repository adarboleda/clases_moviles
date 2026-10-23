import 'package:flutter/material.dart';

import '../atoms/boton_principal.dart';
import '../atoms/boton_secundario.dart';
import '../atoms/titulo_texto.dart';
import '../molecules/campo_etiquetado.dart';

class FormularioLogin extends StatelessWidget {
  //mapeo
  final TextEditingController correo;
  final TextEditingController clave;
  final String? errorCorreo;
  final String? errorClave;
  final VoidCallback onLogin;
  final VoidCallback onLimpiar;

  const FormularioLogin({
    super.key,
    required this.correo,
    required this.clave,
    required this.onLogin,
    required this.onLimpiar,
    this.errorCorreo,
    this.errorClave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TituloTexto(texto: 'Login'),
        const SizedBox(height: 40),
        CampoEtiquetado(
          etiqueta: 'Correo electrónico',
          sugerencia: 'Ingrese su correo electrónico',
          icono: Icons.email_outlined,
          controller: correo,
          tipoTeclado: TextInputType.emailAddress,
          error: errorCorreo,
        ),
        const SizedBox(height: 20),
        CampoEtiquetado(
          etiqueta: 'Contraseña',
          sugerencia: 'Ingrese su contraseña',
          icono: Icons.lock_outline,
          controller: clave,
          oculto: true,
          error: errorClave,
        ),
        const SizedBox(height: 40),
        BotonPrincipal(texto: 'LOGIN', onPressed: onLogin),
        const SizedBox(height: 12),
        BotonSecundario(texto: 'LIMPIAR', onPressed: onLimpiar),
      ],
    );
  }
}
