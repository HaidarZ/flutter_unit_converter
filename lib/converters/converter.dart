import 'package:flutter/material.dart';

abstract class Converter {
  String get name;

  IconData get icon;

  Map<String, double> get unitFactors;

  double convert(String fromUnit, String toUnit, double value);
}
