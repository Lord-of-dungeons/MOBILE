import 'dart:math';

class Calculator {
  static double damageReducer(double damage, double armor) {
    double damageMultiplier = damage / (damage + armor);
    double finalDamage = damage * damageMultiplier;
    return _roundDouble(finalDamage, 2);
  }

  static double _roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}
