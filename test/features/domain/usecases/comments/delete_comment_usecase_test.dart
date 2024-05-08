import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/repositories/comment_repository.dart';
import 'package:template/domain/usecases/comments/delete_comment_usecase.dart';

class MockCommentRepository extends Mock implements CommentRepository {}

void main() {
  late MockCommentRepository mockCommentRepository;
  late DeleteCommentUsecase deleteCommentUsecase;

  setUp(() {
    mockCommentRepository = MockCommentRepository();
    deleteCommentUsecase = DeleteCommentUsecase(mockCommentRepository);
  });

  const commentId = 1;

  test('should delete comment from mock repository', () async {
    // Arrange
    when(() => mockCommentRepository.deleteComment(any()))
        .thenAnswer((_) async => const Right(true)); // Return true for successful deletion

    // Act
    final result = await deleteCommentUsecase(const Params(data: commentId));

    // Assert
    expect(result, const Right(true));

    // Verify
    verify(() => mockCommentRepository.deleteComment(any())).called(1);
    verifyNoMoreInteractions(mockCommentRepository);
  });
}