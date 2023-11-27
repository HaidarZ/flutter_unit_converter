import 'package:flutter/material.dart';

import 'converter.dart';

class DataConverter extends Converter {

  @override
  String get name => 'Data';

  @override
  IconData get icon => Icons.code;

  @override
  Map<String, double> get unitFactors => {
    'bytes': 1,
    'kilobytes': 1024,
    'megabytes': 1024 * 1024,
    'gigabytes': 1024 * 1024 * 1024,
    'terabytes': 1024 * 1024 * 1024 * 1024,
  };

  @override
  double convert(String fromUnit, String toUnit, double value) {
    final fromFactor = unitFactors[fromUnit];
    final toFactor = unitFactors[toUnit];
    if (fromFactor == null || toFactor == null) {
      throw Exception('Unsupported unit');
    }
    return value * fromFactor / toFactor;
  }

}
