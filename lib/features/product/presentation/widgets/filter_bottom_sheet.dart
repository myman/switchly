import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:switchly/core/constants/colors.dart';
import 'package:switchly/features/product/presentation/providers/product_provider.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? selectedCategory;
  double? selectedPrice;
  String? selectedColor;

  List<String> categories = [];
  List<String> colors = [];

  @override
  void initState() {
    super.initState();
    final products =
        Provider.of<ProductProvider>(context, listen: false).products;
    categories = products.map((p) => p.category).toSet().toList();
    colors = products.map((p) => p.color).toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Filter Products',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor)),

          const SizedBox(height: 20),

          // Category filter
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Category'),
            items: categories
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (val) => setState(() => selectedCategory = val),
          ),
          // DropdownButtonFormField<String>(
          //   decoration: const InputDecoration(labelText: 'Category'),
          //   items: ['Clothing', 'Shoes', 'Accessories']
          //       .map((c) => DropdownMenuItem(value: c, child: Text(c)))
          //       .toList(),
          //   onChanged: (val) => setState(() => selectedCategory = val),
          // ),

          // Price filter
          DropdownButtonFormField<double>(
            decoration: const InputDecoration(labelText: 'Price'),
            items: [20.0, 30.0, 50.0, 100.0]
                .map((p) => DropdownMenuItem(
                    value: p, child: Text('Under \$${p.toInt()}')))
                .toList(),
            onChanged: (val) => setState(() => selectedPrice = val),
          ),

          // Color filter
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Color'),
            items: colors
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (val) => setState(() => selectedColor = val),
          ),

          const SizedBox(height: 20),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .resetFilters();
                    Navigator.pop(context);
                  },
                  child: const Text('Reset')),
              ElevatedButton(
                onPressed: () {
                  Provider.of<ProductProvider>(context, listen: false)
                      .filterProducts(
                    category: selectedCategory,
                    maxPrice: selectedPrice,
                    color: selectedColor,
                  );
                  Navigator.pop(context);
                },
                child: const Text('Apply Filters'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
