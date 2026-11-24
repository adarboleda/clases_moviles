import 'package:flutter/material.dart';

import 'dart:io';

import '../models/foto.dart';

class FotoItem extends StatelessWidget {
  final Foto foto;

  const FotoItem({super.key, required this.foto});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.file(File(foto.path), width: 55, fit: BoxFit.cover),
      title: Text(foto.nombre),
      subtitle: Text(foto.descripcion),
    );
  }
}
