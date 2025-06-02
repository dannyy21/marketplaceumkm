import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String id,
    required String name,
    required String imageUrl,
    required int price,
  }) : super(id: id, name: name, imageUrl: imageUrl, price: price);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'],
    );
  }
}
