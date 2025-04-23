import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:switchly/core/constants/colors.dart';
import 'package:switchly/features/product/presentation/providers/product_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? selectedCategory;
  RangeValues selectedPrice = const RangeValues(0, 100);
  String? selectedColor;

  List<String> categories = [];
  List<String> colors = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final allProducts = Provider.of<ProductProvider>(context).allProducts;

    setState(() {
      categories = allProducts.map((p) => p.category).toSet().toList();
      colors = allProducts.map((p) => p.color).toSet().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Filter',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .resetFilters();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Reset',
                    style: GoogleFonts.roboto(color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Category giống Brand
            Text(
              'Category',
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Wrap(
              spacing: 8,
              children: categories
                  .map((category) => ChoiceChip(
                        label: Text(category),
                        selected: selectedCategory == category,
                        selectedColor: AppColors.primaryColor,
                        backgroundColor: Colors.white,
                        avatar: selectedCategory == category
                            ? const Icon(
                                FontAwesomeIcons.check,
                                size: 16,
                              )
                            : null,
                        labelStyle: TextStyle(
                          color: selectedCategory == category
                              ? Colors.white
                              : AppColors.textColor,
                          fontWeight: FontWeight.w500,
                        ),
                        onSelected: (selected) {
                          setState(() {
                            selectedCategory = selected ? category : null;
                          });
                        },
                      ))
                  .toList(),
            ),

            const SizedBox(height: 20),

            // Color filter
            Text(
              'Color',
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Wrap(
              spacing: 8,
              children: colors
                  .map((color) => ChoiceChip(
                        label: Text(color),
                        selected: selectedColor == color,
                        selectedColor: AppColors.primaryColor,
                        backgroundColor: Colors.white,
                        avatar: selectedColor == color
                            ? const Icon(
                                FontAwesomeIcons.check,
                                size: 16,
                              )
                            : null,
                        labelStyle: TextStyle(
                          color: selectedColor == color
                              ? Colors.white
                              : AppColors.textColor,
                          fontWeight: FontWeight.w500,
                        ),
                        onSelected: (selected) {
                          setState(() {
                            selectedColor = selected ? color : null;
                          });
                        },
                      ))
                  .toList(),
            ),

            const SizedBox(height: 20),

            // Price Range Slider
            Text(
              'Price Range',
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            RangeSlider(
              activeColor: AppColors.primaryColor,
              values: selectedPrice,
              min: 0,
              max: 100,
              divisions: 20,
              labels: RangeLabels(
                '\$${selectedPrice.start.round()}',
                '\$${selectedPrice.end.round()}',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  selectedPrice = values;
                });
              },
            ),

            const SizedBox(height: 30),

            // Apply Filters Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false)
                    .filterProducts(
                  category: selectedCategory,
                  minPrice: selectedPrice.start, // thêm giá thấp nhất
                  maxPrice: selectedPrice.end,
                  color: selectedColor,
                );
                Navigator.pop(context);
              },
              child: const Text('Show Results'),
            ),
          ],
        ),
      ),
    );
  }
}
