import 'package:flutter/material.dart';

import 'converter.dart';

class WeightConverter extends Converter {
  @override
  String get name => 'Weight';

  @override
  IconData get icon => Icons.line_weight;

  @override
  Map<String, double> get unitFactors => {
        'kilograms': 1,
        'grams': 1000,
        'pounds': 2.20462
  };

  @override
  double convert(String fromUnit, String toUnit, double value) {
    final fromFactor = unitFactors[fromUnit];
    final toFactor = unitFactors[toUnit];
    if (fromFactor == null || toFactor == null) {
      throw Exception('Conversion from $fromUnit to $toUnit is not supported');
    }
    return value / fromFactor * toFactor;
  }

}
