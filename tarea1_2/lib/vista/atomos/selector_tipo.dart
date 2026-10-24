import 'package:flutter/material.dart';

import '../../modelo/tipo_consumidor.dart';

class SelectorTipo extends StatelessWidget {
  final TipoConsumidor? valor;
  final ValueChanged<TipoConsumidor?> onChanged;
  final FormFieldValidator<TipoConsumidor>? validator;

  const SelectorTipo({
    super.key,
    required this.valor,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<TipoConsumidor>(
      initialValue: valor,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        labelText: 'Tipo de consumidor',
        prefixIcon: Icon(Icons.home_work_outlined),
      ),
      items: TipoConsumidor.values
          .map(
            (tipo) => DropdownMenuItem(value: tipo, child: Text(tipo.nombre)),
          )
          .toList(),
    );
  }
}
