import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/entities/category.dart';
import 'package:template/domain/repositories/category_repository.dart';
import 'package:template/domain/usecases/categories/fetch_category_usecase.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}

void main() {

  late FetchCategoryUsecase fetchCategoryUsecase;
  late MockCategoryRepository mockCategoryRepository;

  setUpAll(() => {TestWidgetsFlutterBinding.ensureInitialized()});

  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
    fetchCategoryUsecase = FetchCategoryUsecase(mockCategoryRepository);
  });

  final List<Category> categoryList = [
    const Category(id: 1, name: 'First Category', description: 'First description')
  ];

  test('should get all categories from mock api request', () async{
    // arrange
    when(() => mockCategoryRepository.getAllCategories())
        .thenAnswer((_) async => Right(categoryList));
    // act
    final result = await fetchCategoryUsecase(NoParams());
    //assert
    expect(result, Right(categoryList));
    // verify
    verify(() => mockCategoryRepository.getAllCategories()).called(1);
    verifyNoMoreInteractions(mockCategoryRepository);
  });
}