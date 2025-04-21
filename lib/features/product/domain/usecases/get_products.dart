import 'package:switchly/features/product/domain/entities/product.dart';
import 'package:switchly/features/product/domain/repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<List<Product>> call() async {
    return repository.getProducts();
  }
}
