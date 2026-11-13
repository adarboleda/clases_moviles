// Restaura los datos iniciales de la biblioteca (npm run reset)
const path = require('node:path');

const { escribir } = require('./db');
const { generarSemilla } = require('./semilla');

escribir(path.join(__dirname, '..', 'data', 'db.json'), generarSemilla());
console.log('Datos de la biblioteca restaurados');
