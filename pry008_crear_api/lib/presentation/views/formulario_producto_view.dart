import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/producto.dart';
import '../viewmodels/producto_viewmodel.dart';

class FormularioProductoView extends StatefulWidget {
  const FormularioProductoView({super.key});

  @override
  State<FormularioProductoView> createState() =>
      _FormularioProductoViewState();
}

class _FormularioProductoViewState
    extends State<FormularioProductoView> {

  final nombre = TextEditingController();
  final descripcion = TextEditingController();
  final precio = TextEditingController();

  Producto? producto;
  bool _inicializado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_inicializado) return;
    _inicializado = true;

    producto =
    ModalRoute.of(context)?.settings.arguments
    as Producto?;

    if (producto != null) {
      nombre.text = producto!.nombre;
      descripcion.text = producto!.descripcion;
      precio.text = producto!.precio.toString();
    }
  }

  @override
  void dispose() {
    nombre.dispose();
    descripcion.dispose();
    precio.dispose();
    super.dispose();
  }

  Future<void> guardar() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final vm = context.read<ProductoViewModel>();

    final precioValor =
        double.tryParse(precio.text.trim().replaceAll(',', '.'));

    if (nombre.text.trim().isEmpty || precioValor == null) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Ingresa un nombre y un precio válido'),
        ),
      );
      return;
    }

    final datos = Producto(
      id: producto?.id,
      nombre: nombre.text.trim(),
      descripcion: descripcion.text.trim(),
      precio: precioValor,
    );

    try {
      if (producto == null) {
        await vm.agregar(datos);
      } else {
        await vm.editar(datos);
      }
      navigator.pop();
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('No se pudo guardar el producto'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          producto == null
              ? 'Nuevo producto'
              : 'Editar producto',
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: nombre,
              decoration: const InputDecoration(
                labelText: 'Nombre',
              ),
            ),

            TextField(
              controller: descripcion,
              decoration: const InputDecoration(
                labelText: 'Descripción',
              ),
            ),

            TextField(
              controller: precio,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Precio',
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: guardar,
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}