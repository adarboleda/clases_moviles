// Reglas de negocio de la biblioteca. Funciones puras, sin Express,
// para poder probarlas de forma aislada.

const MAXIMO_ACTIVOS = 3;
const MAXIMO_DIAS = 7;
const FORMATO_FECHA = /^\d{4}-\d{2}-\d{2}$/;
const MS_POR_DIA = 24 * 60 * 60 * 1000;

// Fecha de hoy en formato AAAA-MM-DD según la hora local del servidor
function hoyIso() {
  const ahora = new Date();
  const mes = String(ahora.getMonth() + 1).padStart(2, '0');
  const dia = String(ahora.getDate()).padStart(2, '0');
  return `${ahora.getFullYear()}-${mes}-${dia}`;
}

function esFechaIso(texto) {
  if (typeof texto !== 'string' || !FORMATO_FECHA.test(texto)) return false;
  const fecha = new Date(`${texto}T00:00:00Z`);
  // descarta fechas como 2026-02-30
  return !Number.isNaN(fecha.getTime()) && fecha.toISOString().slice(0, 10) === texto;
}

function sumarDias(fechaIso, dias) {
  const fecha = new Date(`${fechaIso}T00:00:00Z`);
  fecha.setUTCDate(fecha.getUTCDate() + dias);
  return fecha.toISOString().slice(0, 10);
}

function diasEntre(desde, hasta) {
  return Math.round(
    (Date.parse(`${hasta}T00:00:00Z`) - Date.parse(`${desde}T00:00:00Z`)) / MS_POR_DIA,
  );
}

// Un préstamo está vencido si sigue activo y su fecha de devolución ya pasó
function estaVencido(prestamo, hoy) {
  return prestamo.estado === 'activo' && prestamo.fechaDevolucion < hoy;
}

// Devuelve el mensaje de la primera regla que no se cumple, o null si todo es válido
function validarPrestamo({ fechaPrestamo, fechaDevolucion, prestamosEstudiante, libro, hoy }) {
  const dias = diasEntre(fechaPrestamo, fechaDevolucion);
  if (dias <= 0) {
    return 'La fecha de devolución debe ser posterior a la fecha de préstamo';
  }
  if (dias > MAXIMO_DIAS) {
    return `La duración máxima de un préstamo es de ${MAXIMO_DIAS} días`;
  }
  if (prestamosEstudiante.some((p) => estaVencido(p, hoy))) {
    return 'El estudiante tiene un préstamo vencido y no puede solicitar otro libro';
  }
  const activos = prestamosEstudiante.filter((p) => p.estado === 'activo').length;
  if (activos >= MAXIMO_ACTIVOS) {
    return `El estudiante ya tiene ${MAXIMO_ACTIVOS} préstamos activos`;
  }
  if (libro.stockDisponible <= 0) {
    return 'El libro no tiene stock disponible';
  }
  return null;
}

function validarEstudiante({ cedula, nombre, carrera, correo }) {
  const texto = (valor) => (typeof valor === 'string' ? valor.trim() : '');
  if (!/^\d{10}$/.test(texto(cedula))) {
    return 'La cédula debe tener 10 dígitos';
  }
  if (!/^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]{3,}$/.test(texto(nombre))) {
    return 'El nombre solo puede tener letras y al menos 3 caracteres';
  }
  if (texto(carrera).length === 0) {
    return 'La carrera es obligatoria';
  }
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(texto(correo))) {
    return 'El correo no es válido';
  }
  return null;
}

module.exports = {
  MAXIMO_ACTIVOS,
  MAXIMO_DIAS,
  hoyIso,
  esFechaIso,
  sumarDias,
  diasEntre,
  estaVencido,
  validarPrestamo,
  validarEstudiante,
};
