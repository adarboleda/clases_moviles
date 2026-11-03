import 'package:flutter/material.dart';

import '../../model/categoria_model.dart';

class SelectorCategoria extends StatelessWidget {
  final CategoriaModel seleccionada;
  final ValueChanged<CategoriaModel> onSeleccionar;

  const SelectorCategoria({
    super.key,
    required this.seleccionada,
    required this.onSeleccionar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final categoria in CategoriaModel.values)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ChoiceChip(
                showCheckmark: false,
                avatar: Icon(categoria.icono, size: 18),
                label: Text(categoria.nombre),
                selected: categoria == seleccionada,
                onSelected: (_) => onSeleccionar(categoria),
              ),
            ),
          ),
      ],
    );
  }
}
