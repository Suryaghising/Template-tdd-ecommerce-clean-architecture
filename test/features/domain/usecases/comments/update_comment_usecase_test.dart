import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/entities/comment.dart';
import 'package:template/domain/repositories/comment_repository.dart';
import 'package:template/domain/usecases/comments/update_comment_usecase.dart';

class MockCommentRepository extends Mock implements CommentRepository {}

void main() {
  late MockCommentRepository mockCommentRepository;
  late UpdateCommentUsecase updateCommentUsecase;

  setUp(() {
    mockCommentRepository = MockCommentRepository();
    updateCommentUsecase = UpdateCommentUsecase(mockCommentRepository);
  });

  final commentRequest = Comment(id: 1, userId: 1, productId: 1, content: 'Test Comment', createdAt: DateTime(2022, 1, 2));
  final commentResponse = Comment(id: 1, userId: 1, productId: 1, content: 'Updated Comment', createdAt: DateTime(2022, 1, 2));

  test('should update comment and return updated comment from mock repository', () async {
    // Arrange
    when(() => mockCommentRepository.updateComment(commentRequest))
        .thenAnswer((_) async => Right(commentResponse));

    // Act
    final result = await updateCommentUsecase( Params(data: commentRequest));

    // Assert
    expect(result,  Right(commentResponse));

    // Verify
    verify(() => mockCommentRepository.updateComment(commentRequest)).called(1);
    verifyNoMoreInteractions(mockCommentRepository);
  });
}