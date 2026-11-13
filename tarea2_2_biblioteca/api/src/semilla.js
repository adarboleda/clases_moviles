// Datos iniciales de la biblioteca. Las fechas de los préstamos se calculan
// a partir de hoy para que siempre existan préstamos activos, uno vencido
// y algunos devueltos, sin importar el día en que se reinicien los datos.

const { hoyIso, sumarDias } = require('./reglas');

function generarSemilla(hoy = hoyIso()) {
  const fecha = (dias) => sumarDias(hoy, dias);

  const estudiantes = [
    { id: 1, cedula: '1726354890', nombre: 'Ana Torres', carrera: 'Ingeniería de Software', correo: 'ana.torres@universidad.edu.ec' },
    { id: 2, cedula: '1712345678', nombre: 'Luis Pérez', carrera: 'Ingeniería en Sistemas', correo: 'luis.perez@universidad.edu.ec' },
    { id: 3, cedula: '1709876543', nombre: 'María Gómez', carrera: 'Mecatrónica', correo: 'maria.gomez@universidad.edu.ec' },
    { id: 4, cedula: '1755512345', nombre: 'Carlos Ruiz', carrera: 'Ingeniería Civil', correo: 'carlos.ruiz@universidad.edu.ec' },
    { id: 5, cedula: '1798765432', nombre: 'Sofía Andrade', carrera: 'Administración de Empresas', correo: 'sofia.andrade@universidad.edu.ec' },
  ];

  const libros = [
    {
      id: 1, titulo: 'Cien años de soledad', autor: 'Gabriel García Márquez', categoria: 'Literatura',
      anio: 1967, paginas: 432, stockTotal: 3, stockDisponible: 2, portada: '/portadas/cien_anos.jpg',
      descripcion: 'La historia de siete generaciones de la familia Buendía en el pueblo de Macondo, obra cumbre del realismo mágico.',
    },
    {
      id: 2, titulo: 'Don Quijote de la Mancha', autor: 'Miguel de Cervantes', categoria: 'Literatura',
      anio: 1605, paginas: 1056, stockTotal: 2, stockDisponible: 2, portada: '/portadas/quijote.jpg',
      descripcion: 'Las aventuras de un hidalgo que, tras leer demasiados libros de caballería, sale a recorrer el mundo junto a Sancho Panza.',
    },
    {
      id: 3, titulo: 'Clean Code', autor: 'Robert C. Martin', categoria: 'Ingeniería de software',
      anio: 2008, paginas: 464, stockTotal: 2, stockDisponible: 1, portada: '/portadas/clean_code.jpg',
      descripcion: 'Principios y buenas prácticas para escribir código legible, fácil de mantener y de probar.',
    },
    {
      id: 4, titulo: 'Calculus', autor: 'James Stewart', categoria: 'Matemáticas',
      anio: 1999, paginas: 1100, stockTotal: 2, stockDisponible: 2, portada: '/portadas/calculo.jpg',
      descripcion: 'Texto de cálculo diferencial e integral con ejemplos y ejercicios aplicados a la ingeniería.',
    },
    {
      id: 5, titulo: 'Introduction to Algorithms', autor: 'Thomas H. Cormen', categoria: 'Ingeniería de software',
      anio: 1990, paginas: 1292, stockTotal: 1, stockDisponible: 0, portada: '/portadas/algoritmos.jpg',
      descripcion: 'Referencia sobre diseño y análisis de algoritmos: ordenamiento, grafos, programación dinámica y más.',
    },
    {
      id: 6, titulo: 'El principito', autor: 'Antoine de Saint-Exupéry', categoria: 'Literatura',
      anio: 1943, paginas: 96, stockTotal: 4, stockDisponible: 3, portada: '/portadas/principito.jpg',
      descripcion: 'Un piloto perdido en el desierto conoce a un pequeño príncipe que viene de otro planeta.',
    },
    {
      id: 7, titulo: 'Software Engineering', autor: 'Ian Sommerville', categoria: 'Ingeniería de software',
      anio: 2011, paginas: 790, stockTotal: 2, stockDisponible: 1, portada: '/portadas/sommerville.jpg',
      descripcion: 'Procesos, requisitos, diseño, pruebas y evolución del software en proyectos reales.',
    },
    {
      id: 8, titulo: 'Huasipungo', autor: 'Jorge Icaza', categoria: 'Literatura',
      anio: 1934, paginas: 195, stockTotal: 3, stockDisponible: 3, portada: '/portadas/huasipungo.jpg',
      descripcion: 'Novela ecuatoriana que denuncia la explotación de los indígenas en las haciendas de la sierra.',
    },
    {
      id: 9, titulo: 'Rayuela', autor: 'Julio Cortázar', categoria: 'Literatura',
      anio: 1963, paginas: 633, stockTotal: 2, stockDisponible: 2, portada: '/portadas/rayuela.jpg',
      descripcion: 'Novela que puede leerse en distinto orden y sigue a Horacio Oliveira entre París y Buenos Aires.',
    },
    {
      id: 10, titulo: 'Sapiens', autor: 'Yuval Noah Harari', categoria: 'Historia',
      anio: 2011, paginas: 496, stockTotal: 2, stockDisponible: 2, portada: '/portadas/sapiens.jpg',
      descripcion: 'Breve historia de la humanidad desde los primeros homínidos hasta la revolución científica.',
    },
    {
      id: 11, titulo: 'University Physics', autor: 'Hugh D. Young', categoria: 'Ciencias',
      anio: 1949, paginas: 1598, stockTotal: 2, stockDisponible: 2, portada: '/portadas/fisica.jpg',
      descripcion: 'Física universitaria: mecánica, ondas, termodinámica, electromagnetismo y física moderna.',
    },
    {
      id: 12, titulo: 'Design Patterns', autor: 'Erich Gamma', categoria: 'Ingeniería de software',
      anio: 1994, paginas: 395, stockTotal: 2, stockDisponible: 1, portada: '/portadas/patrones.jpg',
      descripcion: 'Catálogo de 23 patrones de diseño orientado a objetos para resolver problemas recurrentes.',
    },
  ];

  const prestamos = [
    // Ana tiene 3 préstamos activos: no puede pedir otro
    { id: 1, estudianteId: 1, libroId: 3, fechaPrestamo: fecha(-2), fechaDevolucion: fecha(5), estado: 'activo', fechaEntrega: null },
    { id: 2, estudianteId: 1, libroId: 12, fechaPrestamo: fecha(-1), fechaDevolucion: fecha(6), estado: 'activo', fechaEntrega: null },
    { id: 3, estudianteId: 1, libroId: 7, fechaPrestamo: fecha(-3), fechaDevolucion: fecha(4), estado: 'activo', fechaEntrega: null },
    // Luis tiene un préstamo vencido: no puede pedir otro
    { id: 4, estudianteId: 2, libroId: 1, fechaPrestamo: fecha(-10), fechaDevolucion: fecha(-3), estado: 'activo', fechaEntrega: null },
    // María tiene 2 activos y uno devuelto
    { id: 5, estudianteId: 3, libroId: 6, fechaPrestamo: fecha(-5), fechaDevolucion: fecha(2), estado: 'activo', fechaEntrega: null },
    { id: 6, estudianteId: 3, libroId: 5, fechaPrestamo: fecha(-1), fechaDevolucion: fecha(6), estado: 'activo', fechaEntrega: null },
    { id: 7, estudianteId: 3, libroId: 9, fechaPrestamo: fecha(-20), fechaDevolucion: fecha(-14), estado: 'devuelto', fechaEntrega: fecha(-15) },
    // Sofía devolvió su préstamo
    { id: 8, estudianteId: 5, libroId: 10, fechaPrestamo: fecha(-12), fechaDevolucion: fecha(-6), estado: 'devuelto', fechaEntrega: fecha(-7) },
  ];

  return { estudiantes, libros, prestamos };
}

module.exports = { generarSemilla };
