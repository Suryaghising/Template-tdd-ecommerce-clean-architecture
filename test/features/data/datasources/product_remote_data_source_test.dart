import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/error/exception.dart';
import 'package:template/core/services/dummy_product_service.dart';
import 'package:template/data/datasources/product_remote_data_source.dart';
import 'package:template/data/models/product_model.dart';
import 'package:template/data/models/product_request_model.dart';
import 'package:template/domain/entities/product.dart';

import '../../../fixtures/fixture_reader.dart';

class MockDummyProductService extends Mock implements DummyProductService {}

void main() {
  late ProductRemoteDataSource productRemoteDataSource;
  late MockDummyProductService mockDummyProductService;

  setUp(() {
    mockDummyProductService = MockDummyProductService();
    productRemoteDataSource = ProductRemoteDataSourceImpl(mockDummyProductService);
  });

  group('fetchAllProducts', () {

    final productModelList = [
    const ProductModel(id: 1, name: 'Test Product', price: 1234, description: 'Test Description', imageUrl: 'Test Image')
    ];

    final List<dynamic> productListJson = jsonDecode(fixture('product_list.json'));

    test('should return all products from dummy data', () async{
      // arrange
      when(() => mockDummyProductService.getAllProducts())
          .thenAnswer((_) => productListJson);
      // act
      final result = await productRemoteDataSource.getAllProducts();
      // assert
      expect(result, productModelList);
    });
  });

  group('fetchProductById', () {

    ProductModel productModel = ProductModel.fromJson(jsonDecode(fixture('product.json')));

    test('should return product with matching id from dummy data', () async{
      // arrange
      when(() => mockDummyProductService.getProductById(any()))
          .thenAnswer((_) => jsonDecode(fixture('product.json')));
      // act
      final result = await productRemoteDataSource.getProductById(1);
      // assert
      expect(result, productModel);
    });

    test('should throw not found exception when product with matching id is not found', () async {
      // arrange
      when(() => mockDummyProductService.getProductById(any()))
          .thenThrow(NotFoundException());
      // act & assert
      expect(() async => await productRemoteDataSource.getProductById(1), throwsA(isA<NotFoundException>()));
    });
  });

  group('addProduct', () {

    Map<String, dynamic> response = jsonDecode(fixture('product.json'));
    final productRequest = ProductRequestModel(name: 'Test Product', price: 1234, description: 'Test Description', imageUrl: 'Test Image');
    ProductModel productModel = ProductModel.fromJson(jsonDecode(fixture('product.json')));

    test('should return product with id after adding data into dummy data', () async{
      // arrange
      when(() => mockDummyProductService.addProduct(ProductRequestModel.toJson(productRequest)))
          .thenAnswer((_) => response);
      // act
      final result = await productRemoteDataSource.addProduct(productRequest);
      // assert
      expect(result, productModel);
    });

    test('should throw duplicate entry exception when product name already exists', () async {
      // arrange
      when(() => mockDummyProductService.addProduct(any()))
          .thenThrow(DuplicateEntryException());
      // act & assert
      expect(() async => await productRemoteDataSource.addProduct(productRequest), throwsA(isA<DuplicateEntryException>()));
    });
  });

  group('updateProduct', () {
    Map<String, dynamic> response = jsonDecode(fixture('product.json'));
    const productRequest = Product(id: 1, name: 'Test Product', price: 1234, description: 'Test Description', imageUrl: 'Test Image');
    ProductModel productModelRequest = ProductModel(id: productRequest.id, name: productRequest.name, price: productRequest.price, description: productRequest.description, imageUrl: productRequest.imageUrl);
    ProductModel productModel = ProductModel.fromJson(jsonDecode(fixture('product.json')));

    test('should update and return product after updating data into dummy data', () async{
      // arrange
      when(() => mockDummyProductService.updateProduct(ProductModel.toJson(productModelRequest)))
          .thenAnswer((_) => response);
      // act
      final result = await productRemoteDataSource.updateProduct(productRequest);
      // assert
      expect(result, productModel);
    });

    test('should throw not found exception when product with matching id is not found', () async {
      // arrange
      when(() => mockDummyProductService.updateProduct(ProductModel.toJson(productModelRequest)))
          .thenThrow(NotFoundException());
      // act & assert
      expect(() async => await productRemoteDataSource.updateProduct(productRequest), throwsA(isA<NotFoundException>()));
    });
  });

  group('deleteProduct', () {
    int id = 1;

    test('should return true after deleting data into dummy data', () async{
      // arrange
      when(() => mockDummyProductService.deleteProduct(any()))
          .thenAnswer((_) {});
      // act
      final result = await productRemoteDataSource.deleteProduct(id);
      // assert
      expect(result, true);
    });

    test('should throw not found exception when product with matching id is not found', () async {
      // arrange
      when(() => mockDummyProductService.deleteProduct(any()))
          .thenThrow(NotFoundException());
      // act & assert
      expect(() async => await productRemoteDataSource.deleteProduct(id), throwsA(isA<NotFoundException>()));
    });
  });
}