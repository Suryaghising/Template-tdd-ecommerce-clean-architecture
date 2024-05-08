import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/entities/product.dart';
import 'package:template/domain/repositories/product_repository.dart';
import 'package:template/domain/usecases/products/fetch_all_products_usecase.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late MockProductRepository mockProductRepository;
  late FetchAllProductsUsecase fetchAllProductsUsecase;

  setUpAll(() => {TestWidgetsFlutterBinding.ensureInitialized()});

  setUp(() {
    mockProductRepository = MockProductRepository();
    fetchAllProductsUsecase = FetchAllProductsUsecase(mockProductRepository);
  });

  final List<Product> productList = [
    const Product(id: 1, name: 'Product', price: 1234, description: 'Test description', imageUrl: 'test url')
  ];

  test('should get all products from mock api request', () async{
    // arrange
    when(() => mockProductRepository.getAllProducts())
        .thenAnswer((_) async => Right(productList));
    // act
    final result = await fetchAllProductsUsecase(NoParams());
    //assert
    expect(result, Right(productList));
    // verify
    verify(() => mockProductRepository.getAllProducts()).called(1);
    verifyNoMoreInteractions(mockProductRepository);
  });

}