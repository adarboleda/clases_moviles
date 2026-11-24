import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class PerfilView extends StatelessWidget {
  const PerfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: AppColors.tarjeta,
            child: Icon(Icons.person, size: 56, color: AppColors.acento),
          ),
          SizedBox(height: 16),
          Text(
            'Cinéfilo',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 4),
          Text(
            'Cine App',
            style: TextStyle(color: AppColors.textoSecundario),
          ),
        ],
      ),
    );
  }
}
