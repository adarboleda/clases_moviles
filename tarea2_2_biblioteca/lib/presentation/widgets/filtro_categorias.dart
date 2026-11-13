import 'package:flutter/material.dart';

class FiltroCategorias extends StatelessWidget {
  final List<String> categorias;
  final String? seleccionada;
  final ValueChanged<String?> onSeleccionar;
  final EdgeInsets padding;

  const FiltroCategorias({
    super.key,
    required this.categorias,
    required this.seleccionada,
    required this.onSeleccionar,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  });

  @override
  Widget build(BuildContext context) {
    Widget chip(String etiqueta, String? valor) {
      final activo = seleccionada == valor;
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ChoiceChip(
          label: Text(etiqueta),
          selected: activo,
          labelStyle: TextStyle(color: activo ? Colors.white : null),
          onSelected: (_) => onSeleccionar(valor),
        ),
      );
    }

    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: padding,
        children: [
          chip('Todos', null),
          for (final categoria in categorias) chip(categoria, categoria),
        ],
      ),
    );
  }
}
