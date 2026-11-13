//las fechas se manejan sin hora y en UTC para que la diferencia en dias sea exacta
DateTime soloFecha(DateTime fecha) =>
    DateTime.utc(fecha.year, fecha.month, fecha.day);

DateTime fechaDeHoy() => soloFecha(DateTime.now());

int diasEntre(DateTime desde, DateTime hasta) =>
    soloFecha(hasta).difference(soloFecha(desde)).inDays;

//formato AAAA-MM-DD que usa la API
String aIso(DateTime fecha) {
  final f = soloFecha(fecha);
  final mes = f.month.toString().padLeft(2, '0');
  final dia = f.day.toString().padLeft(2, '0');
  return '${f.year}-$mes-$dia';
}

DateTime desdeIso(String texto) => soloFecha(DateTime.parse(texto));
