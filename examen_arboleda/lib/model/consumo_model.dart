class ConsumoModel {
  //condiciones del plan
  static const int minutosPlan = 300;
  static const double gigasPlan = 10;
  static const double costoMinutoExtra = 0.05;
  static const double costoGigaExtra = 2.0;

  final int minutos;
  final double gigas;
  final int minutosExceso;
  final double gigasExceso;
  final double costoMinutos;
  final double costoGigas;
  final double totalAdicional;

  ConsumoModel({
    required this.minutos,
    required this.gigas,
    required this.minutosExceso,
    required this.gigasExceso,
    required this.costoMinutos,
    required this.costoGigas,
    required this.totalAdicional,
  });

  bool get tieneExceso => totalAdicional > 0;
}
