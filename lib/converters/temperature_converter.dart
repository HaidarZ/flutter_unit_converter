import 'package:flutter/material.dart';

import 'converter.dart';

class TemperatureConverter extends Converter {

  @override
  String get name => 'Temperature';

  @override
  IconData get icon => Icons.thermostat_outlined;

  @override
  Map<String, double> get unitFactors => {
        'Celsius': 1,
        'Fahrenheit': 1,
        'Kelvin': 1,
  };

  @override
  double convert(String fromUnit, String toUnit, double value) {
    double result = 0;
    switch (fromUnit) {
      case 'Celsius':
        if (toUnit == 'Fahrenheit') {
          result = (value * 9 / 5) + 32;
        } else if (toUnit == 'Kelvin') {
          result = value + 273.15;
        }
        break;
      case 'Fahrenheit':
        if (toUnit == 'Celsius') {
          result = (value - 32) * 5 / 9;
        } else if (toUnit == 'Kelvin') {
          result = (value - 32) * 5 / 9 + 273.15;
        }
        break;
      case 'Kelvin':
        if (toUnit == 'Celsius') {
          result = value - 273.15;
        } else if (toUnit == 'Fahrenheit') {
          result = (value - 273.15) * 9 / 5 + 32;
        }
        break;
      default:
        throw Exception('Unsupported unit');
    }
    return result;
  }

}
