import 'package:template/domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel(
      {required super.id, required super.name, required super.description});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  static Map<String, dynamic> toJson(CategoryModel categoryModel) {
    return {
      'id': categoryModel.id,
      'name': categoryModel.name,
      'description': categoryModel.description
    };
  }
}