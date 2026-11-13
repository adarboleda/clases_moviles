import 'package:flutter/material.dart';

import '../utils/recargar.dart';
import 'estudiantes_view.dart';
import 'explorar_view.dart';
import 'prestamos_view.dart';

//pantalla principal con la barra de navegacion inferior
class InicioView extends StatefulWidget {
  const InicioView({super.key});

  @override
  State<InicioView> createState() => _InicioViewState();
}

class _InicioViewState extends State<InicioView> {
  int indice = 0;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;
      recargarTodo(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: indice,
        children: [
          ExplorarView(onVerPrestamos: () => setState(() => indice = 1)),
          const PrestamosView(),
          const EstudiantesView(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: indice,
        onDestinationSelected: (nuevo) => setState(() => indice = nuevo),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explorar',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Préstamos',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Estudiantes',
          ),
        ],
      ),
    );
  }
}
