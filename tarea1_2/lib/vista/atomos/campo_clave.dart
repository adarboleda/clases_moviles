import 'package:flutter/material.dart';

class CampoClave extends StatefulWidget {
  final TextEditingController controller;
  final String etiqueta;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onEnviar;

  const CampoClave({
    super.key,
    required this.controller,
    this.etiqueta = 'Contraseña',
    this.validator,
    this.onEnviar,
  });

  @override
  State<CampoClave> createState() => _CampoClaveState();
}

class _CampoClaveState extends State<CampoClave> {
  bool oculto = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: oculto,
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      onFieldSubmitted: (_) => widget.onEnviar?.call(),
      decoration: InputDecoration(
        labelText: widget.etiqueta,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          tooltip: oculto ? 'Mostrar contraseña' : 'Ocultar contraseña',
          icon: Icon(oculto ? Icons.visibility_outlined : Icons.visibility_off),
          onPressed: () => setState(() => oculto = !oculto),
        ),
      ),
    );
  }
}
