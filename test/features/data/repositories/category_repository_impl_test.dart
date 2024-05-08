import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/error/exception.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/data/models/category_request_model.dart';
import 'package:template/data/repositories/category_repository_impl.dart';
import 'package:template/data/datasources/category_remote_data_source.dart';
import 'package:template/data/models/category_model.dart';
import 'package:template/domain/entities/category.dart';

class MockCategoryRemoteDataSource extends Mock implements CategoryRemoteDataSource {}

void main() {
  late MockCategoryRemoteDataSource mockCategoryRemoteDataSource;
  late CategoryRepositoryImpl categoryRepositoryImpl;

  setUp(() {
    mockCategoryRemoteDataSource = MockCategoryRemoteDataSource();
    categoryRepositoryImpl = CategoryRepositoryImpl(mockCategoryRemoteDataSource);
  });
  
  group('fetchAllCategories', () {

    List<CategoryModel> categoryModelList = [
      CategoryModel(id: 1, name: 'Test category', description: 'Test description')
    ];
    List<Category> categoryList = categoryModelList;
    
    test('should return all categories when the call to remote data source is success', () async{
      // arrange
      when(() => mockCategoryRemoteDataSource.getAllCategories())
          .thenAnswer((_) async => categoryModelList);
      // act
      final result = await categoryRepositoryImpl.getAllCategories();
      // assert
      expect(result, Right(categoryList));
      verify(() => mockCategoryRemoteDataSource.getAllCategories()).called(1);
      verifyNoMoreInteractions(mockCategoryRemoteDataSource);
    });

    test('should return failure when the call to remote data source is failed', () async{
      // arrange
      when(() => mockCategoryRemoteDataSource.getAllCategories())
          .thenThrow(ServerException());
      // act
      final result = await categoryRepositoryImpl.getAllCategories();
      // assert
      expect(result, const Left(ServerFailure()));
    });
  });


  group('fetchCategoryById', () {

    final categoryModel =
      CategoryModel(id: 1, name: 'Test category', description: 'Test description');
    Category category = categoryModel;

    test('should return a category when the call to remote data source is success', () async{
      // arrange
      when(() => mockCategoryRemoteDataSource.getCategoryById(any()))
          .thenAnswer((_) async => categoryModel);
      // act
      final result = await categoryRepositoryImpl.getCategoryById(1);
      // assert
      expect(result, Right(category));
      verify(() => mockCategoryRemoteDataSource.getCategoryById(any())).called(1);
      verifyNoMoreInteractions(mockCategoryRemoteDataSource);
    });

    test('should return failure when the call to remote data source is failed', () async{
      // arrange
      when(() => mockCategoryRemoteDataSource.getCategoryById(any()))
          .thenThrow(ServerException());
      // act
      final result = await categoryRepositoryImpl.getCategoryById(1);
      // assert
      expect(result, const Left(ServerFailure()));
    });

    test('should return failure when the category with given id is not found', () async{
      // arrange
      when(() => mockCategoryRemoteDataSource.getCategoryById(any()))
          .thenThrow(NotFoundException());
      // act
      final result = await categoryRepositoryImpl.getCategoryById(1);
      // assert
      expect(result, const Left(NotFoundFailure()));
    });
  });

  group('addCategory', () {


    CategoryRequestModel categoryRequest = CategoryRequestModel(name: 'Test category', description: 'Test description');
    final categoryModel =
    CategoryModel(id: 1, name: 'Test category', description: 'Test description');
    Category category = categoryModel;

    test('should add and return category with id when the call to remote data source is success', () async{
      // arrange
      when(() => mockCategoryRemoteDataSource.addCategory(categoryRequest))
          .thenAnswer((_) async => categoryModel);
      // act
      final result = await categoryRepositoryImpl.addCategory(categoryRequest);
      // assert
      expect(result, Right(category));
      verify(() => mockCategoryRemoteDataSource.addCategory(categoryRequest)).called(1);
      verifyNoMoreInteractions(mockCategoryRemoteDataSource);
    });

    test('should return failure when the call to remote data source is failed', () async{
      // arrange
      when(() => mockCategoryRemoteDataSource.addCategory(categoryRequest))
          .thenThrow(ServerException());
      // act
      final result = await categoryRepositoryImpl.addCategory(categoryRequest);
      // assert
      expect(result, const Left(ServerFailure()));
    });
  });

  group('updateCategory', () {

    Category categoryRequest = const Category(id: 1, name: 'Test category', description: 'Test description');
    final categoryModel =
    CategoryModel(id: 1, name: 'Updated category', description: 'Updated description');
    Category categoryResponse = categoryModel;

    test('should update and return category when the call to remote data source is success', () async{
      // arrange
      when(() => mockCategoryRemoteDataSource.updateCategory(categoryRequest))
          .thenAnswer((_) async => categoryModel);
      // act
      final result = await categoryRepositoryImpl.updateCategory(categoryRequest);
      // assert
      expect(result, Right(categoryResponse));
      verify(() => mockCategoryRemoteDataSource.updateCategory(categoryRequest)).called(1);
      verifyNoMoreInteractions(mockCategoryRemoteDataSource);
    });

    test('should return failure when the call to remote data source is failed', () async{
      // arrange
      when(() => mockCategoryRemoteDataSource.updateCategory(categoryRequest))
          .thenThrow(ServerException());
      // act
      final result = await categoryRepositoryImpl.updateCategory(categoryRequest);
      // assert
      expect(result, const Left(ServerFailure()));
    });

    test('should return failure when the category with given id is not found', () async{
      // arrange
      when(() => mockCategoryRemoteDataSource.updateCategory(categoryRequest))
          .thenThrow(NotFoundException());
      // act
      final result = await categoryRepositoryImpl.updateCategory(categoryRequest);
      // assert
      expect(result, const Left(NotFoundFailure()));
    });
  });

  group('deleteCategory', () {


    int id = 1;

    test('should return true when the call to remote data source is success', () async{
      // arrange
      when(() => mockCategoryRemoteDataSource.deleteCategory(any()))
          .thenAnswer((_) async => true);
      // act
      final result = await categoryRepositoryImpl.deleteCategory(id);
      // assert
      expect(result, const Right(true));
      verify(() => mockCategoryRemoteDataSource.deleteCategory(any())).called(1);
      verifyNoMoreInteractions(mockCategoryRemoteDataSource);
    });

    test('should return failure when the call to remote data source is failed', () async{
      // arrange
      when(() => mockCategoryRemoteDataSource.deleteCategory(any()))
          .thenThrow(ServerException());
      // act
      final result = await categoryRepositoryImpl.deleteCategory(id);
      // assert
      expect(result, const Left(ServerFailure()));
    });

    test('should return failure when the category with given id is not found', () async{
      // arrange
      when(() => mockCategoryRemoteDataSource.deleteCategory(any()))
          .thenThrow(NotFoundException());
      // act
      final result = await categoryRepositoryImpl.deleteCategory(id);
      // assert
      expect(result, const Left(NotFoundFailure()));
    });
  });
}