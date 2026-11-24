import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/foto_provider.dart';
import '../controllers/foto_controller.dart';
import '../widgets/foto_item.dart';

class FotoView extends StatelessWidget {
  const FotoView({super.key});

  @override
  Widget build(BuildContext context) {
    final fotoProvider = context.watch<FotoProvider>();
    final fotoController = FotoController(fotoProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mis Fotos')),
      body: fotoProvider.fotos.isEmpty
          ? const Center(child: Text('Aún no has tomado fotos'))
          : ListView.builder(
              itemCount: fotoProvider.fotos.length,
              itemBuilder: (_, index) {
                return FotoItem(foto: fotoProvider.fotos[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => fotoController.tomarFoto(context),
        child: const Icon(Icons.camera),
      ),
    );
  }
}
