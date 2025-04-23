import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switchly/core/constants/colors.dart';
import 'package:switchly/features/product/domain/entities/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final horizontalPadding = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          color: AppColors.backgroundColor,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset(
                              product.imageUrl,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Positioned(
                          top: screenHeight * 0.02,
                          left: horizontalPadding,
                          child: _circleIconButton(
                            icon: FontAwesomeIcons.arrowLeft,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Positioned(
                          top: screenHeight * 0.02,
                          right: horizontalPadding,
                          child: _circleIcon(FontAwesomeIcons.heart),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: horizontalPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Text(
                            '\$${product.price}',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: AppColors.primaryColor,
                                ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            'Description',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            product.description,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 14,
                                  color: AppColors.textColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: screenHeight * 0.03,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: screenHeight * 0.07,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Buy Now',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: horizontalPadding),
                  _circleIcon(FontAwesomeIcons.cartPlus),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleIcon(IconData icon) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: Offset(0, 3)),
        ],
      ),
      child: Icon(icon, size: 18, color: AppColors.primaryColor),
    );
  }

  Widget _circleIconButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: IconButton(
        icon: Icon(icon, size: 18, color: AppColors.primaryColor),
        onPressed: onPressed,
      ),
    );
  }
}
