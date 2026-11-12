import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/producto_viewmodel.dart';
import '../../routes/app_routes.dart';

class ProductosView extends StatefulWidget {
  const ProductosView({super.key});

  @override
  State<ProductosView> createState() => _ProductosViewState();
}

class _ProductosViewState extends State<ProductosView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;
      context.read<ProductoViewModel>().cargar();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductoViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.formulario,
              );
            },
          ),
        ],
      ),
      body: vm.cargando
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : vm.error.isNotEmpty
              ? Center(
                  child: Text(vm.error),
                )
              : ListView.builder(
                  itemCount: vm.productos.length,
                  itemBuilder: (context, index) {
                    final producto = vm.productos[index];

                    return Card(
                      child: ListTile(
                        title: Text(producto.nombre),
                        subtitle: Text('\$${producto.precio.toStringAsFixed(2)}'),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.detalle,
                            arguments: producto,
                          );
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.formulario,
                                  arguments: producto,
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                try {
                                  await context
                                      .read<ProductoViewModel>()
                                      .borrar(producto.id!);
                                } catch (_) {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('No se pudo eliminar'),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
