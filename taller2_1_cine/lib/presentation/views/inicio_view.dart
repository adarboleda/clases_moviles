import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/pelicula.dart';
import '../../routes/app_routes.dart';
import '../theme/app_theme.dart';
import '../viewmodels/pelicula_viewmodel.dart';
import '../widgets/poster_pelicula.dart';
import 'avisos_view.dart';
import 'boletos_view.dart';
import 'perfil_view.dart';

/// Pantalla principal: BottomNavigationBar con Inicio / Boletos / Avisos / Perfil.
class InicioView extends StatefulWidget {
  const InicioView({super.key});

  @override
  State<InicioView> createState() => _InicioViewState();
}

class _InicioViewState extends State<InicioView> {
  int _indice = 0;

  static const _paginas = <Widget>[
    _CarteleraTab(),
    BoletosView(),
    AvisosView(),
    PerfilView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: _indice, children: _paginas),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indice,
        onTap: (i) => setState(() => _indice = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_outlined),
            activeIcon: Icon(Icons.movie),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number_outlined),
            activeIcon: Icon(Icons.confirmation_number),
            label: 'Boletos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
            label: 'Avisos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class _CarteleraTab extends StatelessWidget {
  const _CarteleraTab();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PeliculaViewModel>();
    final peliculas = vm.peliculas;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.acento,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.local_movies, color: Colors.black),
              ),
              const SizedBox(width: 12),
              const Text(
                'Cine App',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Text(
            'Hola, cinéfilo',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.only(bottom: 8),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.acento, width: 2),
                ),
              ),
              child: const Text('Cartelera', style: TextStyle(fontSize: 18)),
            ),
          ),
        ),
        const Divider(height: 1, color: AppColors.tarjeta),
        Expanded(
          child: vm.cargando
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.5,
                  ),
                  itemCount: peliculas.length,
                  itemBuilder: (context, i) => _PeliculaCard(
                    pelicula: peliculas[i],
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.reserva,
                      arguments: peliculas[i],
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

class _PeliculaCard extends StatelessWidget {
  final Pelicula pelicula;
  final VoidCallback onTap;

  const _PeliculaCard({required this.pelicula, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.acento, width: 3),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: PosterPelicula(pelicula: pelicula, mostrarTitulo: false),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            pelicula.clasificacion,
            style: const TextStyle(
              color: AppColors.textoSecundario,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            pelicula.titulo.toUpperCase(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
