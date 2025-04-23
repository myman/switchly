import 'package:flutter/material.dart';
import 'package:switchly/features/product/domain/entities/product.dart';
import 'package:switchly/features/product/domain/usecases/get_products.dart';

class ProductProvider with ChangeNotifier {
  final GetProducts getProducts;

  List<Product> _products = [];
  List<Product> _filteredProducts = [];

  List<Product> get products => _filteredProducts;
  List<Product> get allProducts => _products;

  ProductProvider(this.getProducts);

  Future<void> loadProducts() async {
    _products = await getProducts();
    _filteredProducts = List.from(_products);
    notifyListeners();
  }

  void filterProducts(
      {String? category, double? minPrice, double? maxPrice, String? color}) {
    _filteredProducts = _products.where((product) {
      final matchesCategory = category == null || product.category == category;
      final matchesMinPrice = minPrice == null || product.price >= minPrice;
      final matchesMaxPrice = maxPrice == null || product.price <= maxPrice;
      final matchesColor = color == null || product.color == color;
      return matchesCategory &&
          matchesMinPrice &&
          matchesMaxPrice &&
          matchesColor;
    }).toList();
    notifyListeners();
  }

  // Hàm reset filter
  void resetFilters() {
    _filteredProducts = List.from(_products);
    notifyListeners();
  }

  Product findById(String id) => _products.firstWhere((p) => p.id == id);
}
