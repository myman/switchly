import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:switchly/core/constants/colors.dart';
import 'package:switchly/features/product/presentation/providers/product_provider.dart';
import 'package:switchly/features/product/presentation/screens/product_detail_screen.dart';
import 'package:switchly/features/product/presentation/widgets/filter_bottom_sheet.dart';
import 'package:animations/animations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategory = 0;
  final categories = ['Gender', 'Category', 'Price'];

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchAndFilter(screenWidth),
              SizedBox(height: screenHeight * 0.02),
              _buildCategorySelector(),
              SizedBox(height: screenHeight * 0.02),
              _buildProductGrid(products, screenWidth, screenHeight),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(screenHeight),
    );
  }

  Widget _buildSearchAndFilter(double screenWidth) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.white),
                icon: Icon(FontAwesomeIcons.magnifyingGlass,
                    color: Colors.white, size: 18),
              ),
            ),
          ),
        ),
        SizedBox(width: screenWidth * 0.02),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.brown.shade100,
            borderRadius: BorderRadius.circular(14),
          ),
          child: InkWell(
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (_) => FilterBottomSheet(),
            ),
            child: const Icon(FontAwesomeIcons.sliders,
                size: 18, color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.asMap().entries.map((entry) {
        final isSelected = selectedCategory == entry.key;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedCategory = entry.key),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.secondColor),
              ),
              child: Center(
                child: Text(
                  entry.value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isSelected ? Colors.white : AppColors.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProductGrid(
      List products, double screenWidth, double screenHeight) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: screenWidth > 900
              ? 4
              : screenWidth > 600
                  ? 3
                  : 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final bgColor = [0, 2, 5, 7].contains(index % 8)
              ? const Color(0xffE7E6E1)
              : const Color(0xffE5D7CE);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: OpenContainer(
                  transitionType: ContainerTransitionType.fadeThrough,
                  closedElevation: 0,
                  openElevation: 0,
                  transitionDuration: const Duration(milliseconds: 500),
                  closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  openShape: const RoundedRectangleBorder(),
                  closedBuilder: (context, openContainer) => GestureDetector(
                    onTap: openContainer,
                    child: Container(
                      width: double.infinity,
                      color: bgColor,
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        child: Image.asset(
                          product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  openBuilder: (context, _) =>
                      ProductDetailScreen(product: product),
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Text(
                product.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                '\$${product.price}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primaryColor,
                    ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigation(double screenHeight) {
    return Container(
      height: screenHeight * 0.1,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.secondColor,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.heart), label: 'Likes'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.message), label: 'Messages'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.user), label: 'Profile'),
        ],
      ),
    );
  }
}
