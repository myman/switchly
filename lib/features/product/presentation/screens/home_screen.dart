import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:switchly/core/constants/colors.dart';
import 'package:switchly/core/constants/fonts.dart';
import 'package:switchly/features/product/domain/entities/product.dart';
import 'package:switchly/features/product/presentation/providers/product_provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:switchly/features/product/presentation/widgets/filter_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search and Filter
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          icon: Icon(
                            FontAwesomeIcons.magnifyingGlass,
                            color: AppColors.textHide,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => FilterBottomSheet(),
                        );
                      },
                      child: const Icon(FontAwesomeIcons.sliders,
                          size: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Banner
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: AppColors.secondColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Text nội dung banner
                    Positioned(
                      left: 20,
                      top: 30,
                      child: SizedBox(
                        width: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Big Sale',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontFamily: AppFonts.roboto,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Get the trendy fashion at a discount of up to 50%',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontFamily: AppFonts.roboto,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Hình người overlap (phần quan trọng nhất)
                    Positioned(
                      right: 15,
                      bottom: 0,
                      child: SizedBox(
                        height: 180,
                        child: Image.asset('assets/images/person.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Categories
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    categoryButton('All', true),
                    categoryButton('Gender', false),
                    categoryButton('Price', false),
                    categoryButton('Color', false),
                    categoryButton('Popular', false),
                    categoryButton('Recent', false),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Products Grid
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.55,
                  ),
                  itemCount: products.length, // dữ liệu động từ products
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return productCard(product);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // Bottom Navigation
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GNav(
          gap: 8,
          activeColor: Colors.white,
          color: AppColors.textHide,
          iconSize: 20,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 500),
          tabBackgroundColor: AppColors.primary,
          tabs: const [
            GButton(icon: FontAwesomeIcons.house, text: 'Home'),
            GButton(icon: FontAwesomeIcons.heart, text: 'Likes'),
            GButton(icon: FontAwesomeIcons.message, text: 'Messages'),
            GButton(icon: FontAwesomeIcons.user, text: 'Profile'),
          ],
          selectedIndex: 0, // mặc định là tab đầu tiên (Home)
          onTabChange: (index) {
            print('Selected tab: $index');
          },
        ),
      ),
    );
  }

  // Category Button Widget
  Widget categoryButton(String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.primary),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : AppColors.primary,
          fontFamily: AppFonts.roboto,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Product Card Widget
  Widget productCard(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Row chứa name, price và icon favorite
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Expanded/Flexible Column chứa Name và Price tránh tràn
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow
                          .ellipsis, // Hiển thị dấu 3 chấm nếu quá dài
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '\$${product.price}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: AppColors.textHide,
                      ),
                    ),
                  ],
                ),
              ),

              // Icon favorite
              Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  FontAwesomeIcons.solidHeart,
                  color: Colors.white,
                  size: 9,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  // Widget productCard(Product product) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(20),
  //       boxShadow: const [
  //         BoxShadow(
  //           color: Colors.black12,
  //           blurRadius: 8,
  //           offset: Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Expanded(
  //           child: Container(
  //             margin: const EdgeInsets.all(10),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(20),
  //               image: DecorationImage(
  //                 image: AssetImage(product.imageUrl),
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 12),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 product.name,
  //                 style: GoogleFonts.roboto(
  //                   fontSize: 16,
  //                   color: AppColors.textColor,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               const SizedBox(height: 5),
  //               Text(
  //                 '\$${product.price}',
  //                 style: GoogleFonts.roboto(
  //                   fontSize: 14,
  //                   color: AppColors.textHide,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(height: 10),
  //         Align(
  //           alignment: Alignment.bottomRight,
  //           child: Container(
  //             margin: const EdgeInsets.only(right: 12, bottom: 10),
  //             padding: const EdgeInsets.all(6),
  //             decoration: BoxDecoration(
  //               color: Colors.pink[100],
  //               shape: BoxShape.circle,
  //             ),
  //             child: const Icon(Icons.favorite, color: Colors.white, size: 16),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
