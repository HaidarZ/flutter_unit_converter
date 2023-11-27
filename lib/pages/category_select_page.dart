import 'package:flutter/material.dart';

import '../converters/all.dart';
import 'conversion_page.dart';

class CategorySelectPage extends StatefulWidget {
  const CategorySelectPage({super.key});

  @override
  State<CategorySelectPage> createState() => _CategorySelectPageState();
}

class _CategorySelectPageState extends State<CategorySelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Unit Converter'),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Unit Converter',
                  applicationVersion: 'v0.0.1',
                  applicationIcon: const Icon(Icons.info_outline),
                  children: [
                    const Text(
                      'This is a university project developed by Haidar Zeineddine',
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: converters.map((converter) {
            return InkWell(
              borderRadius: const BorderRadius.all(Radius.zero),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ConversionPage(converter: converter),
                ));
              },
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                ),
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(converter.icon, color: Colors.white),
                    const SizedBox(height: 10),
                    Text(
                      converter.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ));
  }
}
