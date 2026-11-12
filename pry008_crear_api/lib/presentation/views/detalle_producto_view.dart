import 'package:flutter/material.dart';

import '../../domain/entities/producto.dart';

class DetalleProductoView extends StatelessWidget {
  const DetalleProductoView({super.key});

  @override
  Widget build(BuildContext context) {
    final producto = ModalRoute.of(context)!.settings.arguments as Producto;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('ID'),
                trailing: Text('${producto.id}'),
              ),
              ListTile(
                title: const Text('Nombre'),
                subtitle: Text(producto.nombre),
              ),
              ListTile(
                title: const Text('Descripción'),
                subtitle: Text(producto.descripcion),
              ),
              ListTile(
                title: const Text('Precio'),
                trailing: Text(
                  '\$${producto.precio.toStringAsFixed(2)}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
