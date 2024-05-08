import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/data/models/category_request_model.dart';
import 'package:template/domain/entities/category.dart';
import 'package:template/domain/repositories/category_repository.dart';
import 'package:template/domain/usecases/categories/add_category_usecase.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}

void main() {

  late AddCategoryUsecase addCategoryUsecase;
  late MockCategoryRepository mockCategoryRepository;

  setUpAll(() => {TestWidgetsFlutterBinding.ensureInitialized()});

  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
    addCategoryUsecase = AddCategoryUsecase(mockCategoryRepository);
  });


    final categoryRequest = CategoryRequestModel(name: 'Test category', description: 'Test description');
    const categoryResponse = Category(id: 1, name: 'Test category', description: 'Test description');


  test('should add category and return category with id from mock api request', () async{
    // arrange
    when(() => mockCategoryRepository.addCategory(categoryRequest))
        .thenAnswer((_) async => const Right(categoryResponse));
    // act
    final result = await addCategoryUsecase(Params(data: categoryRequest));
    //assert
    expect(result, const Right(categoryResponse));
    // verify
    verify(()=> mockCategoryRepository.addCategory(categoryRequest)).called(1);
    verifyNoMoreInteractions(mockCategoryRepository);
  });
}