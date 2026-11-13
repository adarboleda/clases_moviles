# Biblioteca universitaria

Aplicación Flutter para registrar estudiantes, consultar libros disponibles y gestionar préstamos. Usa Provider, MVVM, Clean Architecture, rutas nombradas y consume una API REST propia hecha con Node.js y Express (carpeta `api/`).

## Cómo ejecutarla

### 1. Iniciar la API

```bash
cd api
npm install
npm start
```

La API queda en el puerto 3000 y muestra en consola las direcciones para la PC, el emulador y los celulares de la misma red Wi-Fi. Los datos se guardan en `api/data/db.json`; para volver a los datos iniciales ejecuta `npm run reset`. Las pruebas de la API se ejecutan con `npm test`.

### 2. Ejecutar la app

| Dónde se ejecuta | Comando |
|---|---|
| Emulador Android | `flutter run` (usa `http://10.0.2.2:3000`) |
| Windows o navegador | `flutter run -d windows` o `flutter run -d chrome` (usa `http://localhost:3000`) |
| Celular físico | `flutter run --dart-define=API_URL=http://IP_DE_TU_PC:3000` |

Para generar un APK que funcione en un celular, usa la IP que muestra la API al iniciar:

```bash
flutter build apk --release --dart-define=API_URL=http://192.168.1.10:3000
```

El celular y la PC deben estar en la misma red, y el Firewall de Windows debe permitir conexiones entrantes a Node.js.

## Estructura

```
lib/
├── core/            Configuración de la API y utilidades de fechas
├── domain/          Entidades, contratos de repositorios, casos de uso y reglas de negocio
├── data/            Fuentes de datos HTTP, modelos JSON e implementación de repositorios
├── presentation/    ViewModels (Provider), vistas, widgets y tema
├── routes/          Rutas nombradas
└── main.dart        Inyección de dependencias y MaterialApp
api/
├── src/             Servidor Express, reglas de negocio y datos iniciales
├── public/portadas  Portadas de los libros
└── test/            Pruebas de la API
```

## Endpoints de la API

| Método | Ruta | Descripción |
|---|---|---|
| GET | `/estudiantes` | Lista de estudiantes |
| POST | `/estudiantes` | Registra un estudiante |
| GET | `/libros?disponibles=true` | Libros (opcionalmente solo con stock) |
| GET | `/libros/:id` | Un libro |
| GET | `/prestamos?estudianteId=1` | Préstamos (opcionalmente de un estudiante) |
| POST | `/prestamos` | Registra un préstamo y resta 1 al stock |
| PATCH | `/prestamos/:id` | `{"estado": "devuelto"}` registra la devolución y suma 1 al stock |

## Reglas de negocio

Se validan en la app (`lib/domain/reglas`) y otra vez en la API (`api/src/reglas.js`):

- Un estudiante no puede tener más de 3 préstamos activos.
- Un libro solo puede prestarse si hay stock disponible.
- La fecha de devolución debe ser posterior a la fecha de préstamo.
- La duración máxima de un préstamo es de 7 días.
- Un estudiante con un préstamo vencido no puede solicitar otro libro.
- Registrar un préstamo resta 1 al stock y registrar una devolución suma 1.
- Un préstamo devuelto no puede volver a estado activo.

Las portadas de los libros provienen de [Open Library](https://openlibrary.org).
