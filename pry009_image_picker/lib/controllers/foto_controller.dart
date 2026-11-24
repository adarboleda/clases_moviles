import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/foto.dart';
import '../providers/foto_provider.dart';

class FotoController {
  //instanciar
  final FotoProvider provider;
  final ImagePicker picker = ImagePicker();

  FotoController(this.provider);

  Future<void> tomarFoto(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);

    try {
      final XFile? foto = await picker.pickImage(source: ImageSource.camera);
      if (foto == null) return;

      provider.agregarFoto(
        Foto(
          path: foto.path,
          nombre: 'Foto${provider.fotos.length + 1}',
          descripcion: 'Foto guardada de forma exitosa',
        ),
      );
      //notificacion
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Foto guardada de forma exitosa'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('No se pudo acceder a la cámara'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
