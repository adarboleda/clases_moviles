import 'package:flutter/material.dart';

import '../../model/producto_model.dart';

class TarjetaProducto extends StatelessWidget {
  final ProductoModel producto;
  final int cantidad;

  const TarjetaProducto({
    super.key,
    required this.producto,
    required this.cantidad,
  });

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;

    final tarjeta = Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            producto.imagen,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          producto.nombre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(producto.descripcion),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${producto.precio.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: esquema.primary,
              ),
            ),
            //cantidad que ya esta en el carrito
            if (cantidad > 0)
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: esquema.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'x$cantidad',
                  style: TextStyle(
                    color: esquema.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    //gesto de arrastrar: mantener presionado y llevar el producto al carrito
    return LongPressDraggable<ProductoModel>(
      data: producto,
      delay: const Duration(milliseconds: 300),
      feedback: _FichaArrastre(producto: producto),
      childWhenDragging: Opacity(opacity: 0.4, child: tarjeta),
      child: tarjeta,
    );
  }
}

//vista del producto que sigue al dedo mientras se arrastra
class _FichaArrastre extends StatelessWidget {
  final ProductoModel producto;

  const _FichaArrastre({required this.producto});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.05,
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 220,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  producto.imagen,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  producto.nombre,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
