import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/estudiante.dart';
import '../../domain/errores/biblioteca_exception.dart';
import '../../domain/reglas/validador_estudiante.dart';
import '../theme/app_tema.dart';
import '../viewmodels/estudiante_viewmodel.dart';
import '../widgets/aviso.dart';

class FormularioEstudianteView extends StatefulWidget {
  const FormularioEstudianteView({super.key});

  @override
  State<FormularioEstudianteView> createState() =>
      _FormularioEstudianteViewState();
}

class _FormularioEstudianteViewState extends State<FormularioEstudianteView> {
  static const carreras = [
    'Administración de Empresas',
    'Biotecnología',
    'Electrónica',
    'Ingeniería Civil',
    'Ingeniería de Software',
    'Ingeniería en Sistemas',
    'Mecánica',
    'Mecatrónica',
  ];

  final formKey = GlobalKey<FormState>();
  final cedula = TextEditingController();
  final nombre = TextEditingController();
  final correo = TextEditingController();
  String? carrera;
  bool guardando = false;
  String? errorEnvio;

  @override
  void dispose() {
    cedula.dispose();
    nombre.dispose();
    correo.dispose();
    super.dispose();
  }

  Future<void> guardar() async {
    if (!formKey.currentState!.validate()) return;

    final navigator = Navigator.of(context);
    final vm = context.read<EstudianteViewModel>();

    setState(() {
      guardando = true;
      errorEnvio = null;
    });

    try {
      await vm.registrar(
        Estudiante(
          id: null,
          cedula: cedula.text.trim(),
          nombre: nombre.text.trim(),
          carrera: carrera!,
          correo: correo.text.trim(),
        ),
      );
      navigator.pop(true);
    } on BibliotecaException catch (e) {
      setState(() => errorEnvio = e.mensaje);
    } catch (_) {
      setState(() => errorEnvio = 'No se pudo registrar el estudiante');
    } finally {
      if (mounted) setState(() => guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textos = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Registrar estudiante')),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Center(
              child: CircleAvatar(
                radius: 36,
                backgroundColor: AppColores.verdeClaro,
                child: Icon(
                  Icons.person_add_alt_1,
                  size: 34,
                  color: AppColores.verde,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Nuevo estudiante',
              textAlign: TextAlign.center,
              style: textos.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              'Completa los datos para registrarlo en la biblioteca',
              textAlign: TextAlign.center,
              style: textos.bodyMedium,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: cedula,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 10,
              validator: ValidadorEstudiante.cedula,
              decoration: const InputDecoration(
                labelText: 'Cédula',
                prefixIcon: Icon(Icons.badge_outlined),
                counterText: '',
              ),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: nombre,
              textCapitalization: TextCapitalization.words,
              validator: ValidadorEstudiante.nombre,
              decoration: const InputDecoration(
                labelText: 'Nombre completo',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: carrera,
              isExpanded: true,
              validator: ValidadorEstudiante.carrera,
              decoration: const InputDecoration(
                labelText: 'Carrera',
                prefixIcon: Icon(Icons.school_outlined),
              ),
              items: [
                for (final opcion in carreras)
                  DropdownMenuItem(value: opcion, child: Text(opcion)),
              ],
              onChanged: (valor) => setState(() => carrera = valor),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: correo,
              keyboardType: TextInputType.emailAddress,
              validator: ValidadorEstudiante.correo,
              decoration: const InputDecoration(
                labelText: 'Correo institucional',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            if (errorEnvio != null) ...[
              const SizedBox(height: 16),
              Aviso(tipo: TipoAviso.error, mensaje: errorEnvio!),
            ],
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: FilledButton.icon(
            onPressed: guardando ? null : guardar,
            icon: const Icon(Icons.check),
            label: const Text('Registrar estudiante'),
          ),
        ),
      ),
    );
  }
}
