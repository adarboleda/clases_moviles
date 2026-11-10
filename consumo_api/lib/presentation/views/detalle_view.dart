import 'package:flutter/material.dart';

import '../../domain/entities/item.dart';

class DetalleView extends StatelessWidget {
  const DetalleView({super.key});

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Item;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle')),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(title: const Text('ID'), trailing: Text('${item.id}')),

              ListTile(
                title: const Text('Nombre'),
                trailing: Text(item.nombre),
              ),

              ListTile(
                title: const Text('Especie'),
                trailing: Text(item.especie),
              ),

              ListTile(
                title: const Text('Género'),
                trailing: Text(item.genero),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
