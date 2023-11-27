import 'converter.dart';

class WeightConverter extends Converter {
  WeightConverter() {
    unitFactors = {
      'kilograms': 1,
      'grams': 1000,
      'pounds': 2.20462,
    };
    defaultUnit = 'kilograms';
  }

  @override
  double convert(String fromUnit, String toUnit, double value) {
    final fromFactor = unitFactors[fromUnit];
    final toFactor = unitFactors[toUnit];
    if (fromFactor == null || toFactor == null) {
      throw Exception(
          'Conversion from $fromUnit to $toUnit is not supported');
    }
    return value / fromFactor * toFactor;
  }
}
