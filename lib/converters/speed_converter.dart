import 'package:flutter/material.dart';

import 'converter.dart';

class SpeedConverter extends Converter {

  @override
  String get name => 'Speed';

  @override
  IconData get icon => Icons.speed;

  @override
  Map<String, double> get unitFactors => {
        'meters/second': 1,
        'kilometers/hour': 3.6,
        'miles/hour': 2.23694,
        'feet/second': 3.28084,
  };

  @override
  double convert(String fromUnit, String toUnit, double value) {
    final fromFactor = unitFactors[fromUnit];
    final toFactor = unitFactors[toUnit];
    if (fromFactor == null || toFactor == null) {
      throw Exception('Unsupported unit');
    }
    return value / fromFactor * toFactor;
  }

}
