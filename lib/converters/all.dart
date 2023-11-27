import 'package:flutter/material.dart';

import 'length_converter.dart';
import 'temperature_converter.dart';
import 'converter_category.dart';
import 'weight_converter.dart';

List<ConverterCategory> converterCategories = [
  ConverterCategory(
    title: 'Temperature',
    icon: Icons.thermostat,
    converter: TemperatureConverter(),
  ),
  ConverterCategory(
    title: 'Length',
    icon: Icons.straighten,
    converter: LengthConverter(),
  ),
  ConverterCategory(
    title: 'Weight',
    icon: Icons.scale,
    converter: WeightConverter(),
  )
];
