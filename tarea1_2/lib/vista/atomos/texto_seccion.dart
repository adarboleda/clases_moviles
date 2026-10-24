import 'package:flutter/material.dart';

class TextoSeccion extends StatelessWidget {
  final String texto;

  const TextoSeccion({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        texto.toUpperCase(),
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
