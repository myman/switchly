import 'package:switchly/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}
