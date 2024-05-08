import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/repositories/product_repository.dart';
import 'package:template/domain/usecases/products/delete_product_usecase.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late MockProductRepository mockProductRepository;
  late DeleteProductUsecase deleteProductUsecase;

  setUp(() {
    mockProductRepository = MockProductRepository();
    deleteProductUsecase = DeleteProductUsecase(mockProductRepository);
  });

  const productId = 1;

  test('should delete product from mock repository', () async {
    // Arrange
    when(() => mockProductRepository.deleteProduct(any()))
        .thenAnswer((_) async => const Right(true)); // Return true for successful deletion

    // Act
    final result = await deleteProductUsecase(const Params(data: productId));

    // Assert
    expect(result, const Right(true));

    // Verify
    verify(() => mockProductRepository.deleteProduct(any())).called(1);
    verifyNoMoreInteractions(mockProductRepository);
  });
}