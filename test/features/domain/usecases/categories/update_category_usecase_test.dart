import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/entities/category.dart';
import 'package:template/domain/repositories/category_repository.dart';
import 'package:template/domain/usecases/categories/update_category_usecase.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}

void main() {
  late UpdateCategoryUsecase updateCategoryUsecase;
  late MockCategoryRepository mockCategoryRepository;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
    updateCategoryUsecase = UpdateCategoryUsecase(mockCategoryRepository);
  });

  const categoryRequest = Category(
    id: 1,
    name: 'Test category',
    description: 'Test description',
  );
  const updatedCategory = Category(
    id: 1,
    name: 'Updated test category',
    description: 'Updated test description',
  );

  test('should update category and return updated category from mock repository', () async {
    // Arrange
    when(() => mockCategoryRepository.updateCategory(categoryRequest))
        .thenAnswer((_) async => const Right(updatedCategory));

    // Act
    final result = await updateCategoryUsecase(const Params(data: categoryRequest));

    // Assert
    expect(result, const Right(updatedCategory));

    // Verify
    verify(() => mockCategoryRepository.updateCategory(categoryRequest)).called(1);
    verifyNoMoreInteractions(mockCategoryRepository);
  });
}