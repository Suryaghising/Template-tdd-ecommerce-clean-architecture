import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/error/exception.dart';
import 'package:template/core/services/dummy_category_service.dart';

void main() {
  late DummyCategoryService dummyDataService;

  setUp(() {
    dummyDataService = DummyCategoryServiceImpl();
  });

  List<dynamic> expectedCategories = [
    {'id': 1, 'name': 'Electronics', 'description': 'Electronic devices and gadgets'},
    {'id': 2, 'name': 'Clothing', 'description': 'Apparel and fashion accessories'},
    {'id': 3, 'name': 'Books', 'description': 'Books of various genres'},
    {'id': 4, 'name': 'Home & Kitchen', 'description': 'Household items and appliances'},
    {'id': 5, 'name': 'Sports & Outdoors', 'description': 'Sporting goods and outdoor equipment'},
  ];

  group('getCategories', () {
    test('should return a list of dummy categories', () {
      // Act
      final categories = dummyDataService.getCategories();

      // Assert
      expect(categories, equals(expectedCategories));
    });

  });

  group('getCategoryById', () {
    int id = 1;
    test('should return category with matching id', () {
      // act
      final category = dummyDataService.getCategoryById(id);
      // assert
      expect(category, isNotNull);
    });

    test('should throw NotFoundException for non-existent id', () {
      // assert
      expect(() => dummyDataService.getCategoryById(8), throwsA(isA<NotFoundException>()));
    });
  });

  group('addCategory', () {
    test('should add a new category to the list', () {
      // Arrange
      final newCategory = {'id': 6, 'name': 'New Category', 'description': 'New category description'};
      final initialCategories = dummyDataService.getCategories();

      // Act
      dummyDataService.addCategory(newCategory);
      final categoriesAfterAddition = dummyDataService.getCategories();
      final addedCategory = categoriesAfterAddition.firstWhere((category) => category['id'] == 6);
      // Assert
      expect(addedCategory, isNotNull);
      expect(categoriesAfterAddition.length, equals(initialCategories.length + 1));
    });

    test('should throw duplicate entry exception when category name already exists', () {
      // arrange
      final newCategory = {'id': 6, 'name': 'Electronics', 'description': 'New category description'};

      // assert
      expect(() =>dummyDataService.addCategory(newCategory), throwsA(isA<DuplicateEntryException>()));
    });
  });

  group('updateCategory', () {
    test('should update the category with matching id', () {
      // Arrange
      final updatedCategory = {'id': 2, 'name': 'Updated Clothing', 'description': 'Updated description'};

      // Act
      dummyDataService.updateCategory(updatedCategory);
      final updatedCategoryFromService = dummyDataService.getCategoryById(2);

      // Assert
      expect(updatedCategoryFromService, equals(updatedCategory));
    });

    test('updateCategory should throw NotFoundException for non-existent id', () {
      // Arrange
      final nonExistentCategory = {'id': 10, 'name': 'Non-existent', 'description': 'Non-existent description'};

      // Act & Assert
      expect(() => dummyDataService.updateCategory(nonExistentCategory), throwsA(isA<NotFoundException>()));
    });
  });


  group('deleteCategory', () {
    test('should remove the category with matching id', () {
      // Arrange
      int id = 4;
      final categories = dummyDataService.getCategories();
      // Act
      dummyDataService.deleteCategory(id);
      final categoriesAfterDeletion = dummyDataService.getCategories();
      int index = categoriesAfterDeletion.indexWhere((element) => element['id'] as int == id);
      // Assert
      expect(index, -1);
      expect(categoriesAfterDeletion.length, categories.length-1);
    });


    test('deleteCategory should throw an exception for non-existent id', () {
      // Act & Assert
      expect(() => dummyDataService.deleteCategory(10), throwsA(isA<NotFoundException>()));
    });
  });

}
