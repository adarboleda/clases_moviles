import 'package:flutter/material.dart';

import '../../domain/entities/estudiante.dart';
import '../theme/app_tema.dart';

class AvatarEstudiante extends StatelessWidget {
  final Estudiante estudiante;
  final double radio;

  const AvatarEstudiante({
    super.key,
    required this.estudiante,
    this.radio = 24,
  });

  static const _colores = [
    AppColores.verde,
    AppColores.naranja,
    Color(0xFF5B8DEF),
    Color(0xFF9B6BD6),
    Color(0xFFE0A030),
  ];

  String get iniciales {
    final partes = estudiante.nombre
        .trim()
        .split(RegExp(r'\s+'))
        .where((parte) => parte.isNotEmpty)
        .take(2);
    return partes.map((parte) => parte[0].toUpperCase()).join();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radio,
      backgroundColor: _colores[(estudiante.id ?? 0) % _colores.length],
      child: Text(
        iniciales,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: radio * 0.7,
        ),
      ),
    );
  }
}
