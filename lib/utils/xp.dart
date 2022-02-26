class Xp {
  late BigInt _xp;

  // constructeur
  Xp(String xp) {
    _xp = BigInt.parse(xp);
  }

  BigInt getLevel() {
    return _xp == BigInt.zero ? BigInt.one : _xp;
  }
}
