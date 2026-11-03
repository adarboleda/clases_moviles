import 'categoria_model.dart';

class ProductoModel {
  final String id;
  final String nombre;
  final String descripcion;
  final double precio;
  final CategoriaModel categoria;
  final String imagen;

  const ProductoModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.categoria,
    required this.imagen,
  });

  //productos que ofrece el restaurante
  static const List<ProductoModel> catalogo = [
    ProductoModel(
      id: 'p1',
      nombre: 'Hamburguesa clásica',
      descripcion: 'Carne de res, queso, huevo y vegetales',
      precio: 6.50,
      categoria: CategoriaModel.platos,
      imagen: 'assets/images/hamburguesa.jpg',
    ),
    ProductoModel(
      id: 'p2',
      nombre: 'Pollo frito',
      descripcion: 'Piezas crujientes con papas fritas',
      precio: 5.75,
      categoria: CategoriaModel.platos,
      imagen: 'assets/images/pollo_frito.jpg',
    ),
    ProductoModel(
      id: 'p3',
      nombre: 'Espagueti a la boloñesa',
      descripcion: 'Pasta con salsa de carne y tomate',
      precio: 6.00,
      categoria: CategoriaModel.platos,
      imagen: 'assets/images/espagueti.jpg',
    ),
    ProductoModel(
      id: 'p4',
      nombre: 'Milanesa con papas',
      descripcion: 'Filete apanado con papas y limón',
      precio: 7.25,
      categoria: CategoriaModel.platos,
      imagen: 'assets/images/milanesa.jpg',
    ),
    ProductoModel(
      id: 'p5',
      nombre: 'Empanadas de carne',
      descripcion: 'Tres empanadas horneadas',
      precio: 4.50,
      categoria: CategoriaModel.platos,
      imagen: 'assets/images/empanadas.jpg',
    ),
    ProductoModel(
      id: 'b1',
      nombre: 'Limonada',
      descripcion: 'Limón natural con hielo',
      precio: 1.75,
      categoria: CategoriaModel.bebidas,
      imagen: 'assets/images/limonada.jpg',
    ),
    ProductoModel(
      id: 'b2',
      nombre: 'Limonada de fresa',
      descripcion: 'Limonada con fresas naturales',
      precio: 2.25,
      categoria: CategoriaModel.bebidas,
      imagen: 'assets/images/limonada_fresa.jpg',
    ),
    ProductoModel(
      id: 'b3',
      nombre: 'Café helado',
      descripcion: 'Café frío con leche',
      precio: 2.50,
      categoria: CategoriaModel.bebidas,
      imagen: 'assets/images/cafe_helado.jpg',
    ),
    ProductoModel(
      id: 'b4',
      nombre: 'Batido de plátano',
      descripcion: 'Plátano, leche y canela',
      precio: 2.75,
      categoria: CategoriaModel.bebidas,
      imagen: 'assets/images/batido_platano.jpg',
    ),
    ProductoModel(
      id: 'b5',
      nombre: 'Batido de mango',
      descripcion: 'Mango y naranja',
      precio: 2.75,
      categoria: CategoriaModel.bebidas,
      imagen: 'assets/images/batido_mango.jpg',
    ),
    ProductoModel(
      id: 'b6',
      nombre: 'Té helado',
      descripcion: 'Té negro con leche y hielo',
      precio: 2.00,
      categoria: CategoriaModel.bebidas,
      imagen: 'assets/images/te_helado.jpg',
    ),
    ProductoModel(
      id: 'd1',
      nombre: 'Flan de caramelo',
      descripcion: 'Flan casero con caramelo',
      precio: 2.50,
      categoria: CategoriaModel.postres,
      imagen: 'assets/images/flan.jpg',
    ),
    ProductoModel(
      id: 'd2',
      nombre: 'Churros',
      descripcion: 'Con salsa de chocolate',
      precio: 3.00,
      categoria: CategoriaModel.postres,
      imagen: 'assets/images/churros.jpg',
    ),
    ProductoModel(
      id: 'd3',
      nombre: 'Arroz con leche',
      descripcion: 'Con canela y pasas',
      precio: 2.25,
      categoria: CategoriaModel.postres,
      imagen: 'assets/images/arroz_leche.jpg',
    ),
    ProductoModel(
      id: 'd4',
      nombre: 'Cheesecake',
      descripcion: 'Pastel de queso estilo Nueva York',
      precio: 3.50,
      categoria: CategoriaModel.postres,
      imagen: 'assets/images/cheesecake.jpg',
    ),
    ProductoModel(
      id: 'd5',
      nombre: 'Brownie',
      descripcion: 'Chocolate con frambuesas',
      precio: 3.25,
      categoria: CategoriaModel.postres,
      imagen: 'assets/images/brownie.jpg',
    ),
  ];
}
