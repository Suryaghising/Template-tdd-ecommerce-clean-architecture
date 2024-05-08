import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/repositories/category_repository.dart';
import 'package:template/domain/usecases/categories/delete_category_usecase.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}

void main() {
  late DeleteCategoryUsecase deleteCategoryUsecase;
  late MockCategoryRepository mockCategoryRepository;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
    deleteCategoryUsecase = DeleteCategoryUsecase(mockCategoryRepository);
  });

  const categoryId = 1;

  test('should delete category from mock repository', () async {
    // Arrange
    when(() => mockCategoryRepository.deleteCategory(categoryId))
        .thenAnswer((_) async => const Right(true)); // Return true for successful deletion

    // Act
    final result = await deleteCategoryUsecase(const Params(data: categoryId));

    // Assert
    expect(result, const Right(true));

    // Verify
    verify(() => mockCategoryRepository.deleteCategory(categoryId)).called(1);
    verifyNoMoreInteractions(mockCategoryRepository);
  });
}
