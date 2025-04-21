import 'package:flutter/material.dart';
import 'package:switchly/features/product/domain/entities/product.dart';
import 'package:switchly/features/product/domain/usecases/get_products.dart';

class ProductProvider with ChangeNotifier {
  final GetProducts getProducts;

  List<Product> _products = [];
  List<Product> _filteredProducts = [];

  List<Product> get products => _filteredProducts;

  ProductProvider(this.getProducts);

  Future<void> loadProducts() async {
    _products = await getProducts();
    _filteredProducts = List.from(_products); // Ban đầu hiển thị tất cả
    notifyListeners();
  }

  // Hàm filter sản phẩm theo điều kiện
  void filterProducts({String? category, double? maxPrice, String? color}) {
    _filteredProducts = _products.where((product) {
      final matchesCategory = category == null || product.category == category;
      final matchesPrice = maxPrice == null || product.price <= maxPrice;
      final matchesColor = color == null || product.color == color;

      return matchesCategory && matchesPrice && matchesColor;
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
