import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:template/data/models/product_model.dart';
import 'package:template/domain/entities/product.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const productModel = ProductModel(id: 1, name: 'Test Product', price: 1234, description: 'Test Description', imageUrl: 'Test Image');

  test('should be a subclass of category entity', () {
    // assert
    expect(productModel, isA<Product>());
  });

  test('should return a valid model when json is parsed', () {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(fixture('product.json'));
    // act
    final result = ProductModel.fromJson(jsonMap);
    // assert
    expect(result, equals(productModel));
  });
}