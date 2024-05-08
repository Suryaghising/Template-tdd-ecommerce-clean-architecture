import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/entities/product.dart';
import 'package:template/domain/repositories/product_repository.dart';
import 'package:template/domain/usecases/products/update_product_usecase.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late MockProductRepository mockProductRepository;
  late UpdateProductUsecase updateProductUsecase;

  setUp(() {
    mockProductRepository = MockProductRepository();
    updateProductUsecase = UpdateProductUsecase(mockProductRepository);
  });

  const productRequest = Product(id: 1, name: 'Product', price: 1234, description: 'Test description', imageUrl: 'test url');
  const productResponse =  Product(id: 1, name: 'Product', price: 12345, description: 'Updated description', imageUrl: 'test url');

  test('should update product and return updated product from mock repository', () async {
    // Arrange
    when(() => mockProductRepository.updateProduct(productRequest))
        .thenAnswer((_) async => const Right(productResponse));

    // Act
    final result = await updateProductUsecase(const Params(data: productRequest));

    // Assert
    expect(result, const Right(productResponse));

    // Verify
    verify(() => mockProductRepository.updateProduct(productRequest)).called(1);
    verifyNoMoreInteractions(mockProductRepository);
  });
}