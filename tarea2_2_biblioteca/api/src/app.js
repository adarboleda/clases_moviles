const path = require('node:path');
const express = require('express');
const cors = require('cors');

const reglas = require('./reglas');

function crearApp({ db, hoy = reglas.hoyIso }) {
  const app = express();
  app.use(cors());
  app.use(express.json());
  app.use('/portadas', express.static(path.join(__dirname, '..', 'public', 'portadas')));

  const datos = () => db.datos;
  const buscar = (lista, id) => lista.find((item) => item.id === Number(id));
  const siguienteId = (lista) => lista.reduce((max, item) => Math.max(max, item.id), 0) + 1;
  const responderError = (res, codigo, mensaje) => res.status(codigo).json({ mensaje });

  // Agrega al préstamo los datos del estudiante y del libro para mostrarlos en la app
  const conDetalle = (prestamo) => {
    const estudiante = buscar(datos().estudiantes, prestamo.estudianteId);
    const libro = buscar(datos().libros, prestamo.libroId);
    return {
      ...prestamo,
      estudianteNombre: estudiante?.nombre ?? '',
      libroTitulo: libro?.titulo ?? '',
      libroPortada: libro?.portada ?? '',
    };
  };

  app.get('/', (req, res) => {
    res.json({
      nombre: 'API Biblioteca universitaria',
      recursos: ['/estudiantes', '/libros', '/prestamos'],
    });
  });

  // ---------- Estudiantes ----------

  app.get('/estudiantes', (req, res) => {
    res.json(datos().estudiantes);
  });

  app.get('/estudiantes/:id', (req, res) => {
    const estudiante = buscar(datos().estudiantes, req.params.id);
    if (!estudiante) return responderError(res, 404, 'Estudiante no encontrado');
    res.json(estudiante);
  });

  app.post('/estudiantes', (req, res) => {
    const cuerpo = req.body ?? {};
    const mensaje = reglas.validarEstudiante(cuerpo);
    if (mensaje) return responderError(res, 400, mensaje);

    const cedula = cuerpo.cedula.trim();
    if (datos().estudiantes.some((e) => e.cedula === cedula)) {
      return responderError(res, 409, 'Ya existe un estudiante con esa cédula');
    }

    const estudiante = {
      id: siguienteId(datos().estudiantes),
      cedula,
      nombre: cuerpo.nombre.trim(),
      carrera: cuerpo.carrera.trim(),
      correo: cuerpo.correo.trim().toLowerCase(),
    };
    datos().estudiantes.push(estudiante);
    db.guardar();
    res.status(201).json(estudiante);
  });

  // ---------- Libros ----------

  // ?disponibles=true devuelve solo los libros con stock disponible
  app.get('/libros', (req, res) => {
    let libros = datos().libros;
    if (req.query.disponibles === 'true') {
      libros = libros.filter((libro) => libro.stockDisponible > 0);
    }
    res.json(libros);
  });

  app.get('/libros/:id', (req, res) => {
    const libro = buscar(datos().libros, req.params.id);
    if (!libro) return responderError(res, 404, 'Libro no encontrado');
    res.json(libro);
  });

  // ---------- Préstamos ----------

  // ?estudianteId=1 y ?estado=activo|devuelto filtran la lista
  app.get('/prestamos', (req, res) => {
    let prestamos = datos().prestamos;
    if (req.query.estudianteId) {
      prestamos = prestamos.filter((p) => p.estudianteId === Number(req.query.estudianteId));
    }
    if (req.query.estado) {
      prestamos = prestamos.filter((p) => p.estado === req.query.estado);
    }
    res.json(prestamos.map(conDetalle));
  });

  app.get('/prestamos/:id', (req, res) => {
    const prestamo = buscar(datos().prestamos, req.params.id);
    if (!prestamo) return responderError(res, 404, 'Préstamo no encontrado');
    res.json(conDetalle(prestamo));
  });

  app.post('/prestamos', (req, res) => {
    const { estudianteId, libroId, fechaPrestamo, fechaDevolucion } = req.body ?? {};

    const estudiante = buscar(datos().estudiantes, estudianteId);
    if (!estudiante) return responderError(res, 404, 'Estudiante no encontrado');
    const libro = buscar(datos().libros, libroId);
    if (!libro) return responderError(res, 404, 'Libro no encontrado');
    if (!reglas.esFechaIso(fechaPrestamo) || !reglas.esFechaIso(fechaDevolucion)) {
      return responderError(res, 400, 'Las fechas deben tener el formato AAAA-MM-DD');
    }

    const mensaje = reglas.validarPrestamo({
      fechaPrestamo,
      fechaDevolucion,
      prestamosEstudiante: datos().prestamos.filter((p) => p.estudianteId === estudiante.id),
      libro,
      hoy: hoy(),
    });
    if (mensaje) return responderError(res, 409, mensaje);

    const prestamo = {
      id: siguienteId(datos().prestamos),
      estudianteId: estudiante.id,
      libroId: libro.id,
      fechaPrestamo,
      fechaDevolucion,
      estado: 'activo',
      fechaEntrega: null,
    };
    datos().prestamos.push(prestamo);
    // al registrar un préstamo el stock disponible disminuye en 1
    libro.stockDisponible -= 1;
    db.guardar();
    res.status(201).json(conDetalle(prestamo));
  });

  // Cambio de estado. Solo se permite pasar de activo a devuelto.
  app.patch('/prestamos/:id', (req, res) => {
    const prestamo = buscar(datos().prestamos, req.params.id);
    if (!prestamo) return responderError(res, 404, 'Préstamo no encontrado');

    const { estado } = req.body ?? {};
    if (estado !== 'activo' && estado !== 'devuelto') {
      return responderError(res, 400, 'El estado debe ser "activo" o "devuelto"');
    }
    if (prestamo.estado === 'devuelto') {
      return responderError(
        res,
        409,
        estado === 'activo'
          ? 'Un préstamo devuelto no puede volver a estado activo'
          : 'El préstamo ya fue devuelto',
      );
    }
    if (estado === 'activo') return res.json(conDetalle(prestamo));

    prestamo.estado = 'devuelto';
    prestamo.fechaEntrega = hoy();
    // al registrar una devolución el stock del libro aumenta en 1
    const libro = buscar(datos().libros, prestamo.libroId);
    if (libro) libro.stockDisponible = Math.min(libro.stockTotal, libro.stockDisponible + 1);
    db.guardar();
    res.json(conDetalle(prestamo));
  });

  // ---------- Errores ----------

  app.use((req, res) => responderError(res, 404, 'Ruta no encontrada'));

  // eslint-disable-next-line no-unused-vars
  app.use((err, req, res, next) => {
    if (err.type === 'entity.parse.failed') {
      return responderError(res, 400, 'El cuerpo de la petición no es un JSON válido');
    }
    console.error(err);
    responderError(res, 500, 'Error interno del servidor');
  });

  return app;
}

module.exports = { crearApp };
