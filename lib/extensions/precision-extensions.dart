import 'dart:math';

import 'package:intl/intl.dart';

extension Precision on double {
  /*double toPrecision(int fractionDigits) {
        double mod = pow(10, fractionDigits.toDouble());
        return ((this * mod).round().toDouble() / mod);
    }*/

  double toRound(int place) {
    return NumberFormat.decimalPattern('pt_BR').parse(this.toPrecisionFixedString(place)) as double;
  }

  double toPrecisionFixed(place) {
    var valueForPlace = pow(10, place);
    return (this * valueForPlace).round() / valueForPlace;
  }

  String toPrecisionFixedString(int place, {bool moeda = false}) {
    final formatter = NumberFormat("#,##0.00", "pt_BR");

    String retorno = '';

    if (moeda) retorno += 'R\$ ';

    retorno += formatter.format(this.toPrecisionFixed(place));

    return retorno;
  }

  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
