import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/categoria_model.dart';
import '../../model/producto_model.dart';
import '../../view_model/pedido_viewmodel.dart';
import '../widgets/selector_categoria.dart';
import '../widgets/tarjeta_producto.dart';
import '../widgets/zona_carrito.dart';

class MenuPantalla extends StatefulWidget {
  const MenuPantalla({super.key});

  @override
  State<MenuPantalla> createState() => _MenuPantallaState();
}

class _MenuPantallaState extends State<MenuPantalla> {
  final clienteController = TextEditingController();
  String? errorCliente;

  //1 si la nueva categoria entra por la derecha, -1 si entra por la izquierda
  int direccion = 1;

  //gesto de deslizamiento horizontal para cambiar de categoria
  void deslizarCategoria(DragEndDetails detalles) {
    final velocidad = detalles.primaryVelocity ?? 0;
    if (velocidad.abs() < 250) return;

    //recibir el view model sin escuchar cambios
    final vm = context.read<PedidoViewModel>();
    if (velocidad < 0) {
      direccion = 1;
      if (!vm.siguienteCategoria()) {
        mostrarMensaje('Ya estás en la última categoría');
      }
    } else {
      direccion = -1;
      if (!vm.categoriaAnterior()) {
        mostrarMensaje('Ya estás en la primera categoría');
      }
    }
  }

  void seleccionarCategoria(CategoriaModel categoria) {
    final vm = context.read<PedidoViewModel>();
    direccion = categoria.index > vm.categoriaSeleccionada.index ? 1 : -1;
    vm.seleccionarCategoria(categoria);
  }

  //se ejecuta al soltar un producto sobre la zona del carrito
  void agregarProducto(ProductoModel producto) {
    final agregado = context.read<PedidoViewModel>().agregar(producto);
    mostrarMensaje(
      agregado
          ? '${producto.nombre} agregado al carrito'
          : 'Máximo ${PedidoViewModel.cantidadMaxima} unidades por producto',
    );
  }

  Future<void> verCarrito() async {
    FocusScope.of(context).unfocus();
    final vm = context.read<PedidoViewModel>();

    final error = vm.validarCliente(clienteController.text);
    setState(() => errorCliente = error);
    if (error != null) return;
    if (vm.carritoVacio) {
      mostrarMensaje('Arrastra al menos un producto al carrito');
      return;
    }

    //paso de parametros a la pantalla del carrito
    final confirmado = await Navigator.pushNamed(
      context,
      '/carrito',
      arguments: clienteController.text.trim(),
    );
    if (!mounted) return;
    if (confirmado == true) clienteController.clear();
  }

  void mostrarMensaje(String texto) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(texto),
          duration: const Duration(milliseconds: 1200),
        ),
      );
  }

  @override
  void dispose() {
    clienteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //escuchar cambios del view model para redibujar
    final vm = context.watch<PedidoViewModel>();
    final productos = vm.productos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú'),
        actions: [
          IconButton(
            tooltip: 'Ver carrito',
            onPressed: verCarrito,
            icon: Badge(
              isLabelVisible: vm.totalArticulos > 0,
              label: Text('${vm.totalArticulos}'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: clienteController,
              textCapitalization: TextCapitalization.words,
              maxLength: 40,
              onChanged: (_) {
                if (errorCliente != null) setState(() => errorCliente = null);
              },
              decoration: InputDecoration(
                labelText: 'Nombre del cliente',
                prefixIcon: const Icon(Icons.person_outline),
                errorText: errorCliente,
                counterText: '',
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SelectorCategoria(
              seleccionada: vm.categoriaSeleccionada,
              onSeleccionar: seleccionarCategoria,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Row(
              children: [
                Icon(
                  Icons.swipe,
                  size: 18,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Desliza para cambiar de categoría. Mantén presionado un '
                    'producto y arrástralo al carrito.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragEnd: deslizarCategoria,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animacion) => FadeTransition(
                  opacity: animacion,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0.25 * direccion, 0),
                      end: Offset.zero,
                    ).animate(animacion),
                    child: child,
                  ),
                ),
                child: ListView.builder(
                  key: ValueKey(vm.categoriaSeleccionada),
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                  itemCount: productos.length,
                  itemBuilder: (context, indice) => TarjetaProducto(
                    producto: productos[indice],
                    cantidad: vm.cantidadDe(productos[indice]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ZonaCarrito(
        totalArticulos: vm.totalArticulos,
        total: vm.subtotal,
        onAgregar: agregarProducto,
        onVerCarrito: verCarrito,
      ),
    );
  }
}
