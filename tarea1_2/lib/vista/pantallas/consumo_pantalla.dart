import 'package:flutter/material.dart';

import '../../controlador/pago_controlador.dart';
import '../../modelo/consumo_modelo.dart';
import '../../modelo/tipo_consumidor.dart';
import '../organismos/formulario_consumo.dart';
import '../organismos/tarjeta_tarifas.dart';

class ConsumoPantalla extends StatefulWidget {
  const ConsumoPantalla({super.key});

  @override
  State<ConsumoPantalla> createState() => _ConsumoPantallaState();
}

class _ConsumoPantallaState extends State<ConsumoPantalla> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController cuentaController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController anteriorController = TextEditingController();
  final TextEditingController actualController = TextEditingController();
  final PagoControlador controlador = PagoControlador();

  TipoConsumidor? tipo;

  Future<void> calcularPago() async {
    if (!formKey.currentState!.validate()) return;

    final datos = ConsumoModelo(
      numeroCuenta: cuentaController.text.trim(),
      nombreCliente: nombreController.text.trim(),
      lecturaAnterior: int.parse(anteriorController.text),
      lecturaActual: int.parse(actualController.text),
      tipo: tipo!,
    );
    final resultado = controlador.calcularPago(datos);

    //paso de parametros, la pantalla de detalle devuelve true si se pagó
    final pagado = await Navigator.pushNamed(
      context,
      '/detalle',
      arguments: resultado,
    );
    if (!mounted) return;
    if (pagado == true) limpiar();
  }

  void limpiar() {
    formKey.currentState!.reset();
    setState(() => tipo = null);
  }

  void cerrarSesion() {
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  void dispose() {
    cuentaController.dispose();
    nombreController.dispose();
    anteriorController.dispose();
    actualController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usuario = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de consumo'),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: cerrarSesion,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Bienvenido, ${usuario ?? 'usuario'}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4.0),
                  const Text(
                    'Ingrese los datos del medidor para calcular el valor a pagar.',
                  ),
                  const SizedBox(height: 16.0),
                  const TarjetaTarifas(tarifas: PagoControlador.tarifas),
                  const SizedBox(height: 16.0),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: FormularioConsumo(
                        formKey: formKey,
                        cuentaController: cuentaController,
                        nombreController: nombreController,
                        anteriorController: anteriorController,
                        actualController: actualController,
                        tipo: tipo,
                        onTipoChanged: (valor) => setState(() => tipo = valor),
                        validarCuenta: controlador.validarCuenta,
                        validarNombre: controlador.validarNombre,
                        validarAnterior: controlador.validarLecturaAnterior,
                        validarActual: (valor) =>
                            controlador.validarLecturaActual(
                              valor,
                              anteriorController.text,
                            ),
                        validarTipo: controlador.validarTipo,
                        callback: calcularPago,
                        onLimpiar: limpiar,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
