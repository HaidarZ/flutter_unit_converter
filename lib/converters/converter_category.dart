import 'package:flutter/material.dart';

import 'converter.dart';

class ConverterCategory {
  final String title;
  final IconData icon;
  final Converter converter;

  ConverterCategory({required this.title, required this.icon, required this.converter});
}