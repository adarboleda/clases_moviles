import 'package:flutter/material.dart';

import '../../model/item_carrito_model.dart';

class ItemCarrito extends StatelessWidget {
  final ItemCarritoModel item;
  final VoidCallback onAumentar;
  final VoidCallback onDisminuir;

  const ItemCarrito({
    super.key,
    required this.item,
    required this.onAumentar,
    required this.onDisminuir,
  });

  @override
  Widget build(BuildContext context) {
    final producto = item.producto;

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 12, right: 4),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            producto.imagen,
            width: 52,
            height: 52,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          producto.nombre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '\$${producto.precio.toStringAsFixed(2)} c/u\n'
          'Subtotal: \$${item.subtotal.toStringAsFixed(2)}',
        ),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Quitar uno',
              onPressed: onDisminuir,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Text(
              '${item.cantidad}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            IconButton(
              tooltip: 'Agregar uno',
              onPressed: onAumentar,
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
      ),
    );
  }
}
