import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../converters/converter.dart';

class ConversionPage extends StatefulWidget {
  final Converter converter;

  const ConversionPage({super.key, required this.converter});

  @override
  State<ConversionPage> createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController decimalController = TextEditingController(text: '2');
  String? fromUnit;
  String? toUnit;
  String value = '';
  bool useScientificNotation = false;
  bool isFromValueSet = false;

  @override
  void initState() {
    super.initState();
    // listen to changes in the fromController
    fromController.addListener(() {
      setState(() {
        isFromValueSet = fromController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    fromController.dispose();
    decimalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fromUnit = fromUnit ?? widget.converter.unitFactors.keys.first;
    toUnit = toUnit ?? widget.converter.unitFactors.keys.elementAt(1);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.converter.name),
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
              items: widget.converter.unitFactors.keys.map((String value) {
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
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,36}')),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: decimalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Decimal Places',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Use Scientific Notation'),
              value: useScientificNotation,
              onChanged: (bool value) {
                setState(() {
                  useScientificNotation = value;
                });
              },
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
              items: widget.converter.unitFactors.keys.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: isFromValueSet ? _convert : null, // disable if from value is not set
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.refresh),
                    SizedBox(width: 10),
                    Text('Convert'),
                  ],
                )),
            const SizedBox(height: 20),
           if(isFromValueSet && value.isNotEmpty)
             Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Expanded(
                 child:Text(
                   value,
                   overflow: TextOverflow.ellipsis,
                   style: const TextStyle(
                     fontSize: 24,
                     fontWeight: FontWeight.bold,
                   ),
                   textAlign: TextAlign.center,
                 )
               ),
               IconButton(
                 icon: const Icon(Icons.copy),
                 onPressed: () => _copyToClipboard(value)
               ),
             ],
           )
          ],
        ),
      ),
    );
  }

  void _convert() {
    try {
      final double fromValue = double.parse(fromController.text);
      final double result = widget.converter.convert(fromUnit!, toUnit!, fromValue);

      // Parse the number of decimal places from the decimalController.
      // If parsing fails, default to 2 decimal places.
      int decimalPlaces = int.tryParse(decimalController.text) ?? 2;

      // Format the result based on user settings for decimal places and scientific notation.
      String formattedResult;
      if (useScientificNotation) {
        formattedResult = result.toStringAsExponential(decimalPlaces);
      } else {
        formattedResult = result.toStringAsFixed(decimalPlaces);
      }

      // Update the state to show the formatted result.
      setState(() {
        value = "$formattedResult $toUnit";
      });
    } catch (e) {
      // If there is an error, show the error message in the UI.
      setState(() {
        value = "Error: $e";
      });
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
  }

}
