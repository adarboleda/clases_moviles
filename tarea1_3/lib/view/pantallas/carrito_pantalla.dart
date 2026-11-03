import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/entrega_model.dart';
import '../../view_model/pedido_viewmodel.dart';
import '../widgets/item_carrito.dart';

class CarritoPantalla extends StatelessWidget {
  const CarritoPantalla({super.key});

  void confirmarPedido(BuildContext context, String cliente) {
    final vm = context.read<PedidoViewModel>();
    final total = vm.total;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 56),
        title: const Text('Pedido confirmado'),
        content: Text(
          'Gracias, $cliente. Tu pedido de \$${total.toStringAsFixed(2)} '
          '(${vm.entrega.nombre.toLowerCase()}) ya está en preparación.',
          textAlign: TextAlign.center,
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              //regresar al menu indicando que el pedido se confirmo
              Navigator.pop(context, true);
              vm.vaciar();
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //recibir los parametros enviados desde el menu
    final cliente = ModalRoute.of(context)!.settings.arguments as String;
    //escuchar cambios del view model para redibujar
    final vm = context.watch<PedidoViewModel>();
    final esquema = Theme.of(context).colorScheme;

    Widget dato(String titulo, String valor, {bool resaltado = false}) {
      final estilo = TextStyle(
        fontWeight: resaltado ? FontWeight.bold : FontWeight.normal,
        fontSize: resaltado ? 20 : 15,
        color: resaltado ? esquema.primary : null,
      );
      return ListTile(
        dense: !resaltado,
        title: Text(titulo, style: estilo),
        trailing: Text(valor, style: estilo),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito'),
        actions: [
          IconButton(
            tooltip: 'Vaciar carrito',
            onPressed: vm.carritoVacio
                ? null
                : () => context.read<PedidoViewModel>().vaciar(),
            icon: const Icon(Icons.delete_sweep_outlined),
          ),
        ],
      ),
      body: vm.carritoVacio
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.remove_shopping_cart_outlined,
                      size: 80,
                      color: esquema.outline,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Tu carrito está vacío',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Vuelve al menú y arrastra los productos que quieras pedir.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.restaurant_menu),
                      label: const Text('Volver al menú'),
                    ),
                  ],
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  color: esquema.primaryContainer,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: esquema.primary,
                      foregroundColor: esquema.onPrimary,
                      child: const Icon(Icons.person),
                    ),
                    title: const Text('Pedido para'),
                    subtitle: Text(
                      cliente,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    trailing: Text('${vm.totalArticulos} artículo(s)'),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Productos seleccionados',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                for (final item in vm.items)
                  ItemCarrito(
                    item: item,
                    onAumentar: () =>
                        context.read<PedidoViewModel>().agregar(item.producto),
                    onDisminuir: () => context
                        .read<PedidoViewModel>()
                        .disminuir(item.producto),
                  ),
                const SizedBox(height: 16),
                Text(
                  'Tipo de entrega',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Card(
                  child: RadioGroup<EntregaModel>(
                    groupValue: vm.entrega,
                    onChanged: context.read<PedidoViewModel>().cambiarEntrega,
                    child: Column(
                      children: [
                        for (final entrega in EntregaModel.values)
                          RadioListTile<EntregaModel>(
                            value: entrega,
                            secondary: Icon(entrega.icono),
                            title: Text(entrega.nombre),
                            subtitle: Text(
                              entrega.costo == 0
                                  ? 'Sin costo adicional'
                                  : '+ \$${entrega.costo.toStringAsFixed(2)}',
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                //resumen del total de compra
                Card(
                  child: Column(
                    children: [
                      dato('Subtotal', '\$${vm.subtotal.toStringAsFixed(2)}'),
                      dato(
                        'Entrega',
                        '\$${vm.costoEntrega.toStringAsFixed(2)}',
                      ),
                      const Divider(height: 1),
                      dato(
                        'Total',
                        '\$${vm.total.toStringAsFixed(2)}',
                        resaltado: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => confirmarPedido(context, cliente),
                  icon: const Icon(Icons.check),
                  label: const Text('Confirmar pedido'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.restaurant_menu),
                  label: const Text('Seguir comprando'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                  ),
                ),
              ],
            ),
    );
  }
}
