import 'converter.dart';

class LengthConverter extends Converter {
  LengthConverter() {
    unitFactors = {
      'meters': 1,
      'kilometers': 0.001,
      'miles': 0.000621371,
      'yards': 1.09361,
      'feet': 3.28084,
    };
    defaultUnit = 'meters';
  }

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
