import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/data/models/product_request_model.dart';
import 'package:template/domain/entities/product.dart';
import 'package:template/domain/repositories/product_repository.dart';
import 'package:template/domain/usecases/products/add_product_usecase.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late MockProductRepository mockProductRepository;
  late AddProductUsecase addProductUsecase;

  setUp(() {
    mockProductRepository = MockProductRepository();
    addProductUsecase = AddProductUsecase(mockProductRepository);
  });

  final productRequest = ProductRequestModel(name: 'Product', price: 1234, description: 'Test description', imageUrl: 'test url');
  const productResponse = Product(id: 1, name: 'Product', price: 1234, description: 'Test description', imageUrl: 'test url');


  test('should add and return product with id from mock api request', () async{
    // arrange
    when(() => mockProductRepository.addProduct(productRequest))
        .thenAnswer((_) async => const Right(productResponse));
    // act
    final result = await addProductUsecase(Params(data: productRequest));
    //assert
    expect(result, const Right(productResponse));
    // verify
    verify(()=> mockProductRepository.addProduct(productRequest)).called(1);
    verifyNoMoreInteractions(mockProductRepository);
  });
}