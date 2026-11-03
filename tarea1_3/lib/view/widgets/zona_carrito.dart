import 'package:flutter/material.dart';

import '../../model/producto_model.dart';

class ZonaCarrito extends StatelessWidget {
  final int totalArticulos;
  final double total;
  final ValueChanged<ProductoModel> onAgregar;
  final VoidCallback onVerCarrito;

  const ZonaCarrito({
    super.key,
    required this.totalArticulos,
    required this.total,
    required this.onAgregar,
    required this.onVerCarrito,
  });

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;

    //zona donde se sueltan los productos arrastrados
    return DragTarget<ProductoModel>(
      onAcceptWithDetails: (detalles) => onAgregar(detalles.data),
      builder: (context, candidatos, rechazados) {
        //true mientras un producto esta encima de la zona
        final activo = candidatos.isNotEmpty;

        return SafeArea(
          top: false,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.fromLTRB(12, 4, 12, 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: activo
                  ? esquema.primaryContainer
                  : esquema.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: activo ? esquema.primary : esquema.outlineVariant,
                width: activo ? 3 : 1,
              ),
            ),
            child: Row(
              children: [
                AnimatedScale(
                  scale: activo ? 1.3 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Badge(
                    isLabelVisible: totalArticulos > 0,
                    label: Text('$totalArticulos'),
                    child: Icon(
                      Icons.shopping_cart,
                      size: 34,
                      color: esquema.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        activo
                            ? 'Suelta para agregar'
                            : 'Arrastra aquí tus productos',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Total: \$${total.toStringAsFixed(2)}',
                        style: TextStyle(color: esquema.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                FilledButton(
                  onPressed: onVerCarrito,
                  child: const Text('Ver carrito'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
