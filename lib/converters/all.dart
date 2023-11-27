import 'converter.dart';
import 'data_converter.dart';
import 'length_converter.dart';
import 'speed_converter.dart';
import 'temperature_converter.dart';
import 'volume_controller.dart';
import 'weight_converter.dart';

List<Converter> converters = [
  TemperatureConverter(),
  LengthConverter(),
  WeightConverter(),
  DataConverter(),
  VolumeConverter(),
  SpeedConverter()
];
