// ignore_for_file: constant_identifier_names

import 'package:lordofdungeons/screens/play/play_solo_screen.dart';

const TILE_SIZE_SPRITE_SHEET = 16;

double valueByTileSize(double value) {
  return value * (tileSize / TILE_SIZE_SPRITE_SHEET);
}
