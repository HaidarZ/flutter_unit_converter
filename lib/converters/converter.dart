abstract class Converter {
  Map<String, double> unitFactors = {};
  String defaultUnit = '';

  double convert(String fromUnit, String toUnit, double value);
}
