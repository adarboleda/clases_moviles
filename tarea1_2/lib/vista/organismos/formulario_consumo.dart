import 'package:flutter/material.dart';

import '../../modelo/tipo_consumidor.dart';
import '../atomos/boton_principal.dart';
import '../atomos/boton_secundario.dart';
import '../atomos/selector_tipo.dart';
import '../atomos/texto_seccion.dart';
import '../moleculas/entrada_cliente.dart';
import '../moleculas/entrada_lecturas.dart';

class FormularioConsumo extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController cuentaController;
  final TextEditingController nombreController;
  final TextEditingController anteriorController;
  final TextEditingController actualController;
  final TipoConsumidor? tipo;
  final ValueChanged<TipoConsumidor?> onTipoChanged;
  final FormFieldValidator<String> validarCuenta;
  final FormFieldValidator<String> validarNombre;
  final FormFieldValidator<String> validarAnterior;
  final FormFieldValidator<String> validarActual;
  final FormFieldValidator<TipoConsumidor> validarTipo;
  final VoidCallback callback;
  final VoidCallback onLimpiar;

  const FormularioConsumo({
    super.key,
    required this.formKey,
    required this.cuentaController,
    required this.nombreController,
    required this.anteriorController,
    required this.actualController,
    required this.tipo,
    required this.onTipoChanged,
    required this.validarCuenta,
    required this.validarNombre,
    required this.validarAnterior,
    required this.validarActual,
    required this.validarTipo,
    required this.callback,
    required this.onLimpiar,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TextoSeccion(texto: 'Datos del cliente'),
          EntradaCliente(
            cuentaController: cuentaController,
            nombreController: nombreController,
            validarCuenta: validarCuenta,
            validarNombre: validarNombre,
          ),
          const SizedBox(height: 16.0),
          SelectorTipo(
            valor: tipo,
            onChanged: onTipoChanged,
            validator: validarTipo,
          ),
          const SizedBox(height: 24.0),
          const TextoSeccion(texto: 'Lecturas del medidor'),
          EntradaLecturas(
            anteriorController: anteriorController,
            actualController: actualController,
            validarAnterior: validarAnterior,
            validarActual: validarActual,
          ),
          const SizedBox(height: 24.0),
          BotonPrincipal(
            texto: 'Calcular pago',
            icono: Icons.calculate_outlined,
            onPressed: callback,
          ),
          const SizedBox(height: 12.0),
          BotonSecundario(
            texto: 'Limpiar',
            icono: Icons.cleaning_services_outlined,
            onPressed: onLimpiar,
          ),
        ],
      ),
    );
  }
}
