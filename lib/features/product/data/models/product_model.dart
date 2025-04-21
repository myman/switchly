import 'package:switchly/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.price,
    required super.category,
    required super.color,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        price: json["price"].toDouble(),
        category: json["category"],
        color: json["color"],
      );
}
