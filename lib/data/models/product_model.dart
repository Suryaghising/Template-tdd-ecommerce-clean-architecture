import 'package:template/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({required super.id, required super.name, required super.price, required super.description, required super.imageUrl});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(id: json['id'], name: json['name'], price: json['price'], description: json['description'], imageUrl: json['image_url']);

  static Map<String, dynamic> toJson(ProductModel productModelRequest) {
    return {
      'id': productModelRequest.id,
      'name': productModelRequest.name,
      'price': productModelRequest.price,
      'description': productModelRequest.description,
      'image_url': productModelRequest.imageUrl
    };
  }

}