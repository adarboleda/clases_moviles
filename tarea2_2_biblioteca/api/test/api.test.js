const { test, beforeEach, afterEach } = require('node:test');
const assert = require('node:assert/strict');

const { crearApp } = require('../src/app');
const { dbEnMemoria } = require('../src/db');
const { generarSemilla } = require('../src/semilla');

const HOY = '2026-11-12';
let servidor;
let url;
let db;

beforeEach(async () => {
  db = dbEnMemoria(generarSemilla(HOY));
  servidor = crearApp({ db, hoy: () => HOY }).listen(0);
  await new Promise((resolver) => servidor.once('listening', resolver));
  url = `http://localhost:${servidor.address().port}`;
});

afterEach(() => servidor.close());

const pedir = async (metodo, ruta, cuerpo) => {
  const respuesta = await fetch(url + ruta, {
    method: metodo,
    headers: { 'Content-Type': 'application/json' },
    body: cuerpo ? JSON.stringify(cuerpo) : undefined,
  });
  return { estado: respuesta.status, datos: await respuesta.json() };
};

const libro = (id) => db.datos.libros.find((l) => l.id === id);

test('lista libros y filtra los disponibles', async () => {
  const todos = await pedir('GET', '/libros');
  const disponibles = await pedir('GET', '/libros?disponibles=true');
  assert.equal(todos.datos.length, 12);
  assert.ok(disponibles.datos.every((l) => l.stockDisponible > 0));
  assert.equal(disponibles.datos.length, 11);
});

test('registra un préstamo y disminuye el stock en 1', async () => {
  const antes = libro(2).stockDisponible;
  const r = await pedir('POST', '/prestamos', {
    estudianteId: 4, libroId: 2, fechaPrestamo: HOY, fechaDevolucion: '2026-11-19',
  });
  assert.equal(r.estado, 201);
  assert.equal(r.datos.estado, 'activo');
  assert.equal(r.datos.libroTitulo, 'Don Quijote de la Mancha');
  assert.equal(libro(2).stockDisponible, antes - 1);
});

test('rechaza más de 3 préstamos activos', async () => {
  const r = await pedir('POST', '/prestamos', {
    estudianteId: 1, libroId: 2, fechaPrestamo: HOY, fechaDevolucion: '2026-11-15',
  });
  assert.equal(r.estado, 409);
  assert.match(r.datos.mensaje, /3 préstamos activos/);
});

test('rechaza a un estudiante con un préstamo vencido', async () => {
  const r = await pedir('POST', '/prestamos', {
    estudianteId: 2, libroId: 2, fechaPrestamo: HOY, fechaDevolucion: '2026-11-15',
  });
  assert.equal(r.estado, 409);
  assert.match(r.datos.mensaje, /vencido/);
});

test('rechaza un libro sin stock', async () => {
  const r = await pedir('POST', '/prestamos', {
    estudianteId: 4, libroId: 5, fechaPrestamo: HOY, fechaDevolucion: '2026-11-15',
  });
  assert.equal(r.estado, 409);
  assert.match(r.datos.mensaje, /stock/);
});

test('valida la fecha de devolución y la duración máxima', async () => {
  const igual = await pedir('POST', '/prestamos', {
    estudianteId: 4, libroId: 2, fechaPrestamo: HOY, fechaDevolucion: HOY,
  });
  const largo = await pedir('POST', '/prestamos', {
    estudianteId: 4, libroId: 2, fechaPrestamo: HOY, fechaDevolucion: '2026-11-20',
  });
  const invalida = await pedir('POST', '/prestamos', {
    estudianteId: 4, libroId: 2, fechaPrestamo: '2026-02-30', fechaDevolucion: '2026-03-02',
  });
  assert.match(igual.datos.mensaje, /posterior/);
  assert.match(largo.datos.mensaje, /7 días/);
  assert.equal(invalida.estado, 400);
});

test('la devolución aumenta el stock y no se puede reactivar', async () => {
  const antes = libro(6).stockDisponible;
  const devuelto = await pedir('PATCH', '/prestamos/5', { estado: 'devuelto' });
  assert.equal(devuelto.estado, 200);
  assert.equal(devuelto.datos.fechaEntrega, HOY);
  assert.equal(libro(6).stockDisponible, antes + 1);

  const reactivar = await pedir('PATCH', '/prestamos/5', { estado: 'activo' });
  assert.equal(reactivar.estado, 409);
  assert.match(reactivar.datos.mensaje, /no puede volver a estado activo/);

  const otraVez = await pedir('PATCH', '/prestamos/5', { estado: 'devuelto' });
  assert.equal(otraVez.estado, 409);
});

test('registra estudiantes y no repite cédulas', async () => {
  const nuevo = {
    cedula: '1700000001', nombre: 'Pedro Vega', carrera: 'Electrónica', correo: 'pedro@uni.edu.ec',
  };
  const r = await pedir('POST', '/estudiantes', nuevo);
  assert.equal(r.estado, 201);
  assert.equal(r.datos.id, 6);
  assert.equal((await pedir('POST', '/estudiantes', nuevo)).estado, 409);
  assert.equal((await pedir('POST', '/estudiantes', { ...nuevo, cedula: '12' })).estado, 400);
});
