import 'package:flutter/material.dart';

import '../widgets/logo_restaurante.dart';

class SplashPantalla extends StatefulWidget {
  const SplashPantalla({super.key});

  @override
  State<SplashPantalla> createState() => _SplashPantallaState();
}

class _SplashPantallaState extends State<SplashPantalla>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  );

  //aparicion progresiva del logo
  late final Animation<double> opacidad = CurvedAnimation(
    parent: controller,
    curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
  );

  //cambio de tamaño del logo con rebote
  late final Animation<double> escala = Tween<double>(begin: 0.3, end: 1.0)
      .animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.0, 0.8, curve: Curves.elasticOut),
        ),
      );

  //movimiento del nombre desde abajo
  late final Animation<Offset> desplazamiento =
      Tween<Offset>(begin: const Offset(0, 1.5), end: Offset.zero).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
        ),
      );

  late final Animation<double> opacidadTexto = CurvedAnimation(
    parent: controller,
    curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
  );

  @override
  void initState() {
    super.initState();
    controller.addStatusListener((estado) {
      if (estado == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 900), irAlMenu);
      }
    });
    controller.forward();
  }

  void irAlMenu() {
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/menu');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: esquema.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: opacidad,
              child: ScaleTransition(
                scale: escala,
                child: const LogoRestaurante(),
              ),
            ),
            const SizedBox(height: 28),
            FadeTransition(
              opacity: opacidadTexto,
              child: SlideTransition(
                position: desplazamiento,
                child: Column(
                  children: [
                    Text(
                      'El Buen Sabor',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Comida casera a un toque',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
