const _meses = [
  'ene',
  'feb',
  'mar',
  'abr',
  'may',
  'jun',
  'jul',
  'ago',
  'sep',
  'oct',
  'nov',
  'dic',
];

//ejemplo: 12 nov 2026
String formatoFecha(DateTime fecha) =>
    '${fecha.day} ${_meses[fecha.month - 1]} ${fecha.year}';

String formatoDias(int dias) => dias == 1 ? '1 día' : '$dias días';
