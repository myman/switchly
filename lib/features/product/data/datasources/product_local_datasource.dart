import 'package:switchly/features/product/data/models/product_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class ProductLocalDataSource {
  Future<List<ProductModel>> getProductsFromJson() async {
    final String response =
        await rootBundle.loadString('lib/data/products.json');
    final data = json.decode(response) as List;
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }
}
