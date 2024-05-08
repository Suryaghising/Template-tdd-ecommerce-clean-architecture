import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/entities/category.dart';
import 'package:template/domain/entities/product.dart';
import 'package:template/domain/repositories/product_repository.dart';
import 'package:template/domain/usecases/categories/fetch_category_by_id_usecase.dart';
import 'package:template/domain/usecases/products/fetch_product_by_id_usecase.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {

  late FetchProductByIdUsecase fetchProductByIdUsecase;
  late MockProductRepository mockProductRepository;

  setUpAll(() => {TestWidgetsFlutterBinding.ensureInitialized()});

  setUp(() {
    mockProductRepository = MockProductRepository();
    fetchProductByIdUsecase = FetchProductByIdUsecase(mockProductRepository);
  });

  const product = Product(id: 1, name: 'Product', price: 1234, description: 'Test description', imageUrl: 'test url');

  test('should get product by id from mock api request', () async{
    // arrange
    when(() =>mockProductRepository.getProductById(any()))
        .thenAnswer((_) async => const Right(product));
    // act
    final result = await fetchProductByIdUsecase(const Params(data: 1));
    //assert
    expect(result, const Right(product));
    // verify
    verify(() => mockProductRepository.getProductById(any())).called(1);
    verifyNoMoreInteractions(mockProductRepository);
  });
}