import 'package:flutter/material.dart';

class FilaDetalle extends StatelessWidget {
  final String etiqueta;
  final String valor;
  final bool resaltado;

  const FilaDetalle({
    super.key,
    required this.etiqueta,
    required this.valor,
    this.resaltado = false,
  });

  @override
  Widget build(BuildContext context) {
    final textos = Theme.of(context).textTheme;
    final estiloEtiqueta = resaltado ? textos.titleLarge : textos.bodyMedium;
    final estiloValor = resaltado
        ? textos.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          )
        : textos.bodyLarge?.copyWith(fontWeight: FontWeight.w600);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(etiqueta, style: estiloEtiqueta)),
          const SizedBox(width: 12.0),
          Flexible(
            child: Text(valor, textAlign: TextAlign.right, style: estiloValor),
          ),
        ],
      ),
    );
  }
}
