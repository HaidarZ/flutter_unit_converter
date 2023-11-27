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
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: converterCategories.map((category) {
            return InkWell(
              borderRadius: const BorderRadius.all(Radius.zero),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ConversionPage(category: category),
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
                    Icon(category.icon, color: Colors.white),
                    const SizedBox(height: 10),
                    Text(
                      category.title,
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
