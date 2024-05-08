import 'package:flutter_test/flutter_test.dart';
import 'package:template/data/models/category_request_model.dart';

void main() {
  final categoryRequestModel = CategoryRequestModel(name: "Test Category", description: "Test Description");

  test('should return a valid json when object is mapped', () {
    // act
    final result = CategoryRequestModel.toJson(categoryRequestModel);
    // assert
    Map<String, dynamic> json = {
      'name': 'Test Category',
      'description': 'Test Description'
    };
    expect(result, equals(json));
  });
}