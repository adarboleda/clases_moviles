import 'package:flutter/material.dart';

class BarraBusqueda extends StatefulWidget {
  final String valorInicial;
  final ValueChanged<String> onChanged;

  const BarraBusqueda({
    super.key,
    required this.valorInicial,
    required this.onChanged,
  });

  @override
  State<BarraBusqueda> createState() => _BarraBusquedaState();
}

class _BarraBusquedaState extends State<BarraBusqueda> {
  late final controller = TextEditingController(text: widget.valorInicial);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void limpiar() {
    controller.clear();
    widget.onChanged('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      onChanged: (texto) {
        widget.onChanged(texto);
        setState(() {});
      },
      decoration: InputDecoration(
        hintText: 'Buscar por título o autor',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
                tooltip: 'Limpiar búsqueda',
                onPressed: limpiar,
                icon: const Icon(Icons.close),
              ),
      ),
    );
  }
}
