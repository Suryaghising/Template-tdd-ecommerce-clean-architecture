import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/error/exception.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/data/datasources/product_remote_data_source.dart';
import 'package:template/data/models/product_model.dart';
import 'package:template/data/models/product_request_model.dart';
import 'package:template/data/repositories/product_repository_impl.dart';
import 'package:template/domain/entities/product.dart';
import 'package:template/domain/repositories/product_repository.dart';

class MockProductRemoteDataSource extends Mock implements ProductRemoteDataSource {}

void main() {
  late MockProductRemoteDataSource mockProductRemoteDataSource;
  late ProductRepository productRepositoryImpl;

  setUp(() {
    mockProductRemoteDataSource = MockProductRemoteDataSource();
    productRepositoryImpl = ProductRepositoryImpl(mockProductRemoteDataSource);
  });

  group('fetchAllProducts', () {

    List<ProductModel> productModelList = [
    const ProductModel(id: 1, name: 'Test Product', price: 1234, description: 'Test Description', imageUrl: 'Test Image')
    ];
    List<Product> productList = productModelList;

    test('should return all products when the call to remote data source is success', () async{
      // arrange
      when(() => mockProductRemoteDataSource.getAllProducts())
          .thenAnswer((_) async => productModelList);
      // act
      final result = await productRepositoryImpl.getAllProducts();
      // assert
      expect(result, Right(productList));
      verify(() => mockProductRemoteDataSource.getAllProducts()).called(1);
      verifyNoMoreInteractions(mockProductRemoteDataSource);
    });

    test('should return failure when the call to remote data source is failed', () async{
      // arrange
      when(() => mockProductRemoteDataSource.getAllProducts())
          .thenThrow(ServerException());
      // act
      final result = await productRepositoryImpl.getAllProducts();
      // assert
      expect(result, const Left(ServerFailure()));
    });
  });


  group('fetchProductById', () {

    const productModel =
    ProductModel(id: 1, name: 'Test Product', price: 1234, description: 'Test Description', imageUrl: 'Test Image');
    Product product = productModel;

    test('should return a product when the call to remote data source is success', () async{
      // arrange
      when(() => mockProductRemoteDataSource.getProductById(any()))
          .thenAnswer((_) async => productModel);
      // act
      final result = await productRepositoryImpl.getProductById(1);
      // assert
      expect(result, Right(product));
      verify(() => mockProductRemoteDataSource.getProductById(any())).called(1);
      verifyNoMoreInteractions(mockProductRemoteDataSource);
    });

    test('should return failure when the call to remote data source is failed', () async{
      // arrange
      when(() => mockProductRemoteDataSource.getProductById(any()))
          .thenThrow(ServerException());
      // act
      final result = await productRepositoryImpl.getProductById(1);
      // assert
      expect(result, const Left(ServerFailure()));
    });

    test('should return failure when the product with given id is not found', () async{
      // arrange
      when(() => mockProductRemoteDataSource.getProductById(any()))
          .thenThrow(NotFoundException());
      // act
      final result = await productRepositoryImpl.getProductById(1);
      // assert
      expect(result, const Left(NotFoundFailure()));
    });
  });

  group('addProduct', () {


    final productRequest = ProductRequestModel(name: 'Test Product', price: 1234, description: 'Test Description', imageUrl: 'Test Image');
    const productModel = ProductModel(id: 1, name: 'Test Product', price: 1234, description: 'Test Description', imageUrl: 'Test Image');
    Product product = productModel;

    test('should add and return product with id when the call to remote data source is success', () async{
      // arrange
      when(() => mockProductRemoteDataSource.addProduct(productRequest))
          .thenAnswer((_) async => productModel);
      // act
      final result = await productRepositoryImpl.addProduct(productRequest);
      // assert
      expect(result, Right(product));
      verify(() => mockProductRemoteDataSource.addProduct(productRequest)).called(1);
      verifyNoMoreInteractions(mockProductRemoteDataSource);
    });

    test('should return failure when the call to remote data source is failed', () async{
      // arrange
      when(() => mockProductRemoteDataSource.addProduct(productRequest))
          .thenThrow(ServerException());
      // act
      final result = await productRepositoryImpl.addProduct(productRequest);
      // assert
      expect(result, const Left(ServerFailure()));
    });
  });

  group('updateProduct', () {
    const productRequest = Product(id: 1, name: 'Test Product', price: 1234, description: 'Test Description', imageUrl: 'Test Image');
    const productModel = ProductModel(id: 1, name: 'Test Product', price: 12345, description: 'Updated Description', imageUrl: 'Test Image');
    Product productResponse = productModel;

    test('should update and return product when the call to remote data source is success', () async{
      // arrange
      when(() => mockProductRemoteDataSource.updateProduct(productRequest))
          .thenAnswer((_) async => productModel);
      // act
      final result = await productRepositoryImpl.updateProduct(productRequest);
      // assert
      expect(result, Right(productResponse));
      verify(() => mockProductRemoteDataSource.updateProduct(productRequest)).called(1);
      verifyNoMoreInteractions(mockProductRemoteDataSource);
    });

    test('should return failure when the call to remote data source is failed', () async{
      // arrange
      when(() => mockProductRemoteDataSource.updateProduct(productRequest))
          .thenThrow(ServerException());
      // act
      final result = await productRepositoryImpl.updateProduct(productRequest);
      // assert
      expect(result, const Left(ServerFailure()));
    });

    test('should return failure when the product with given id is not found', () async{
      // arrange
      when(() => mockProductRemoteDataSource.updateProduct(productRequest))
          .thenThrow(NotFoundException());
      // act
      final result = await productRepositoryImpl.updateProduct(productRequest);
      // assert
      expect(result, const Left(NotFoundFailure()));
    });
  });

  group('deleteProduct', () {


    int id = 1;

    test('should return true when the call to remote data source is success', () async{
      // arrange
      when(() => mockProductRemoteDataSource.deleteProduct(any()))
          .thenAnswer((_) async => true);
      // act
      final result = await productRepositoryImpl.deleteProduct(id);
      // assert
      expect(result, const Right(true));
      verify(() => mockProductRemoteDataSource.deleteProduct(any())).called(1);
      verifyNoMoreInteractions(mockProductRemoteDataSource);
    });

    test('should return failure when the call to remote data source is failed', () async{
      // arrange
      when(() => mockProductRemoteDataSource.deleteProduct(any()))
          .thenThrow(ServerException());
      // act
      final result = await productRepositoryImpl.deleteProduct(id);
      // assert
      expect(result, const Left(ServerFailure()));
    });

    test('should return failure when the product with given id is not found', () async{
      // arrange
      when(() => mockProductRemoteDataSource.deleteProduct(any()))
          .thenThrow(NotFoundException());
      // act
      final result = await productRepositoryImpl.deleteProduct(id);
      // assert
      expect(result, const Left(NotFoundFailure()));
    });
  });
}