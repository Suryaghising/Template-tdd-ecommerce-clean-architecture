import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/error/exception.dart';
import 'package:template/core/services/dummy_category_service.dart';
import 'package:template/data/datasources/category_remote_data_source.dart';
import 'package:template/data/models/category_model.dart';
import 'package:template/data/models/category_request_model.dart';
import 'package:template/domain/entities/category.dart';

import '../../../fixtures/fixture_reader.dart';

class MockDummyCategoryService extends Mock implements DummyCategoryService {}

void main() {
  late CategoryRemoteDataSource categoryRemoteDataSource;
  late MockDummyCategoryService mockDummyCategoryService;

  setUp(() {
    mockDummyCategoryService = MockDummyCategoryService();
    categoryRemoteDataSource = CategoryRemoteDataSourceImpl(mockDummyCategoryService);
  });

  group('fetchAllCategories', () {

    final categoryModelList = [
      CategoryModel(id: 1, name: 'Test Category', description: 'Test Description')
    ];

    final List<dynamic> categoryListJson = jsonDecode(fixture('category_list.json'));

    test('should return all categories from dummy data', () async{
      // arrange
      when(() => mockDummyCategoryService.getCategories())
          .thenAnswer((_) => categoryListJson);
      // act
      final result = await categoryRemoteDataSource.getAllCategories();
      // assert
      expect(result, categoryModelList);
    });
  });

  group('fetchCategoryById', () {

    CategoryModel category = CategoryModel.fromJson(jsonDecode(fixture('category.json')));

    test('should return category with matching id from dummy data', () async{
      // arrange
      when(() => mockDummyCategoryService.getCategoryById(any()))
          .thenAnswer((_) => jsonDecode(fixture('category.json')));
      // act
      final result = await categoryRemoteDataSource.getCategoryById(1);
      // assert
      expect(result, category);
    });

    test('should throw not found exception when category with matching id is not found', () async {
      // arrange
      when(() => mockDummyCategoryService.getCategoryById(any()))
          .thenThrow(NotFoundException());
      // act & assert
      expect(() async => await categoryRemoteDataSource.getCategoryById(1), throwsA(isA<NotFoundException>()));
    });
  });

  group('addCategory', () {

    Map<String, dynamic> response = jsonDecode(fixture('category.json'));
    final categoryRequest = CategoryRequestModel(name: 'Test Category', description: 'Test Description');
    CategoryModel categoryModel = CategoryModel.fromJson(jsonDecode(fixture('category.json')));

    test('should return category with id after adding data into dummy data', () async{
      // arrange
      when(() => mockDummyCategoryService.addCategory(CategoryRequestModel.toJson(categoryRequest)))
          .thenAnswer((_) => response);
      // act
      final result = await categoryRemoteDataSource.addCategory(categoryRequest);
      // assert
      expect(result, categoryModel);
    });

    test('should throw duplicate entry exception when category name already exists', () async {
      // arrange
      when(() => mockDummyCategoryService.addCategory(any()))
          .thenThrow(DuplicateEntryException());
      // act & assert
      expect(() async => await categoryRemoteDataSource.addCategory(categoryRequest), throwsA(isA<DuplicateEntryException>()));
    });
  });

  group('updateCategory', () {
    Map<String, dynamic> response = jsonDecode(fixture('category.json'));
    const categoryRequest = Category(id: 1, name: 'Category 1', description: 'Description 1');
    CategoryModel categoryModelRequest = CategoryModel(id: categoryRequest.id, name: categoryRequest.name, description: categoryRequest.description);
    CategoryModel categoryModel = CategoryModel.fromJson(jsonDecode(fixture('category.json')));

    test('should update and return category after updating data into dummy data', () async{
      // arrange
      when(() => mockDummyCategoryService.updateCategory(CategoryModel.toJson(categoryModelRequest)))
          .thenAnswer((_) => response);
      // act
      final result = await categoryRemoteDataSource.updateCategory(categoryRequest);
      // assert
      expect(result, categoryModel);
    });

    test('should throw not found exception when category with matching id is not found', () async {
      // arrange
      when(() => mockDummyCategoryService.updateCategory(CategoryModel.toJson(categoryModelRequest)))
          .thenThrow(NotFoundException());
      // act & assert
      expect(() async => await categoryRemoteDataSource.updateCategory(categoryRequest), throwsA(isA<NotFoundException>()));
    });
  });

  group('deleteCategory', () {
    int id = 1;

    test('should return true after deleting data into dummy data', () async{
      // arrange
      when(() => mockDummyCategoryService.deleteCategory(any()))
          .thenAnswer((_) {});
      // act
      final result = await categoryRemoteDataSource.deleteCategory(id);
      // assert
      expect(result, true);
    });

    test('should throw not found exception when category with matching id is not found', () async {
      // arrange
      when(() => mockDummyCategoryService.deleteCategory(any()))
          .thenThrow(NotFoundException());
      // act & assert
      expect(() async => await categoryRemoteDataSource.deleteCategory(id), throwsA(isA<NotFoundException>()));
    });
  });
}