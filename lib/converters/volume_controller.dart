import 'package:flutter/material.dart';

import 'converter.dart';

class VolumeConverter extends Converter {

  @override
  String get name => 'Volume';

  @override
  IconData get icon => Icons.opacity;

  @override
  Map<String, double> get unitFactors => {
        'liters': 1,
        'milliliters': 1000,
        'gallons': 0.264172,
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
