import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../converters/converter_category.dart';

class ConversionPage extends StatefulWidget {
  final ConverterCategory category;

  const ConversionPage({super.key, required this.category});

  @override
  State<ConversionPage> createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {
  final TextEditingController fromController = TextEditingController();
  String fromUnit = '';
  String toUnit = '';
  String value = '';

  @override
  void dispose() {
    fromController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fromUnit = fromUnit != ''
        ? fromUnit
        : widget.category.converter.unitFactors.keys.first;
    toUnit = toUnit != ''
        ? toUnit
        : widget.category.converter.unitFactors.keys.elementAt(1);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField(
              value: fromUnit,
              decoration: const InputDecoration(
                labelText: 'From Unit',
                border: OutlineInputBorder(),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  fromUnit = newValue!;
                });
              },
              items: widget.category.converter.unitFactors.keys
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: fromController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'From Value',
              ),
              // filter the input to only allow numbers and decimal numbers
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: toUnit,
              decoration: const InputDecoration(
                labelText: 'To Unit',
                border: OutlineInputBorder(),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  toUnit = newValue!;
                });
              },
              items: widget.category.converter.unitFactors.keys
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _convert,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.refresh),
                    SizedBox(width: 10),
                    Text('Convert'),
                  ],
                )),
            const SizedBox(height: 20),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _convert() {
    try {
      final double fromValue = double.parse(fromController.text);
      final double result =
          widget.category.converter.convert(fromUnit, toUnit, fromValue);
      setState(() {
        if (result % 1 == 0) {
          value = "${result.toStringAsFixed(0)} $toUnit";
        } else {
          value = "${result.toStringAsFixed(2)} $toUnit";
        }
      });
    } catch (e) {
      setState(() {
        value = 'Invalid input';
      });
    }
  }
}
