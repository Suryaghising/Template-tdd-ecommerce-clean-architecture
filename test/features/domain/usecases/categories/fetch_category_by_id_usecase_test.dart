import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/entities/category.dart';
import 'package:template/domain/repositories/category_repository.dart';
import 'package:template/domain/usecases/categories/fetch_category_by_id_usecase.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}

void main() {

  late FetchCategoryByIdUsecase fetchCategoryByIdUsecase;
  late MockCategoryRepository mockCategoryRepository;

  setUpAll(() => {TestWidgetsFlutterBinding.ensureInitialized()});

  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
    fetchCategoryByIdUsecase = FetchCategoryByIdUsecase(mockCategoryRepository);
  });

    const category = Category(id: 1, name: 'First Category', description: 'First description');

  test('should get category by id from mock api request', () async{
    // arrange
    when(() =>mockCategoryRepository.getCategoryById(any()))
        .thenAnswer((_) async => const Right(category));
    // act
    final result = await fetchCategoryByIdUsecase(const Params(data: 1));
    //assert
    expect(result, const Right(category));
    // verify
    verify(() => mockCategoryRepository.getCategoryById(any())).called(1);
    verifyNoMoreInteractions(mockCategoryRepository);
  });
}