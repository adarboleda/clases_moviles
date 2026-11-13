// Persistencia sencilla: los datos viven en memoria y se guardan
// en un archivo JSON después de cada cambio.

const fs = require('node:fs');
const path = require('node:path');
const { generarSemilla } = require('./semilla');

function escribir(ruta, datos) {
  fs.mkdirSync(path.dirname(ruta), { recursive: true });
  fs.writeFileSync(ruta, JSON.stringify(datos, null, 2));
}

function abrirDb(ruta) {
  if (!fs.existsSync(ruta)) {
    escribir(ruta, generarSemilla());
  }
  return {
    datos: JSON.parse(fs.readFileSync(ruta, 'utf8')),
    guardar() {
      escribir(ruta, this.datos);
    },
  };
}

// Base de datos que no toca el disco, usada en las pruebas
function dbEnMemoria(datos) {
  return { datos, guardar() {} };
}

module.exports = { abrirDb, dbEnMemoria, escribir };
