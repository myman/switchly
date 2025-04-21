import 'package:switchly/features/product/data/datasources/product_local_datasource.dart';
import 'package:switchly/features/product/domain/entities/product.dart';
import 'package:switchly/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl(this.localDataSource);

  @override
  Future<List<Product>> getProducts() => localDataSource.getProductsFromJson();
}
