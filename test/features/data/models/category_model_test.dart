import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:template/data/models/category_model.dart';
import 'package:template/domain/entities/category.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final categoryModel = CategoryModel(id: 1, name: "Test Category", description: "Test Description");

  test('should be a subclass of category entity', () {
    // assert
    expect(categoryModel, isA<Category>());
  });
  
  test('should return a valid model when json is parsed', () {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(fixture('category.json'));
    // act
    final result = CategoryModel.fromJson(jsonMap);
    // assert
    expect(result, equals(categoryModel));
  });
}