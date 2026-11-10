import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/item_viewmodel.dart';
import '../../routes/app_routes.dart';

class ListaView extends StatefulWidget {
  const ListaView({super.key});

  @override
  State<ListaView> createState() => _ListaViewState();
}

class _ListaViewState extends State<ListaView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;
      context.read<ItemViewModel>().cargarItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ItemViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Listado')),

      body: vm.cargando
          ? const Center(child: CircularProgressIndicator())
          : vm.error.isNotEmpty
          ? Center(child: Text(vm.error))
          : ListView.builder(
              itemCount: vm.items.length,

              itemBuilder: (context, index) {
                final item = vm.items[index];

                return Card(
                  child: ListTile(
                    title: Text(item.nombre),

                    subtitle: Text('${item.especie} • ${item.genero}'),

                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.detalle,
                        arguments: item,
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
