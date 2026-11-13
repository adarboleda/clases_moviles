const os = require('node:os');
const path = require('node:path');

const { crearApp } = require('./app');
const { abrirDb } = require('./db');

const PUERTO = Number(process.env.PORT) || 3000;
const db = abrirDb(path.join(__dirname, '..', 'data', 'db.json'));

// 0.0.0.0 permite conexiones desde el emulador y desde celulares en la misma red
crearApp({ db }).listen(PUERTO, '0.0.0.0', () => {
  console.log(`API Biblioteca escuchando en el puerto ${PUERTO}`);
  console.log(`  PC:               http://localhost:${PUERTO}`);
  console.log(`  Emulador Android: http://10.0.2.2:${PUERTO}`);
  for (const interfaces of Object.values(os.networkInterfaces())) {
    for (const red of interfaces ?? []) {
      if (red.family === 'IPv4' && !red.internal) {
        console.log(`  Celular (Wi-Fi):  http://${red.address}:${PUERTO}`);
      }
    }
  }
});
