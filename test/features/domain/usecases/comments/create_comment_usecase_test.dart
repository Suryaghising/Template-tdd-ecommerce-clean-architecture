import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/data/models/comment_request_model.dart';
import 'package:template/domain/entities/comment.dart';
import 'package:template/domain/repositories/comment_repository.dart';
import 'package:template/domain/usecases/comments/create_comment_usecase.dart';

class MockCommentRepository extends Mock implements CommentRepository {}

void main() {
  late MockCommentRepository mockCommentRepository;
  late CreateCommentUsecase createCommentUsecase;

  setUp(() {
    mockCommentRepository = MockCommentRepository();
    createCommentUsecase = CreateCommentUsecase(mockCommentRepository);
  });

  final commentRequest = CommentRequestModel(userId: 1, productId: 1, content: 'Test Content', createdAt: DateTime(2022, 1, 2));
  final commentResponse = Comment(id: 1, userId: 1, productId: 1, content: 'Test Content', createdAt: DateTime(2022, 1, 2));


  test('should add and return comment with id from mock api request', () async{
    // arrange
    when(() => mockCommentRepository.createComment(commentRequest))
        .thenAnswer((_) async => Right(commentResponse));
    // act
    final result = await createCommentUsecase(Params(data: commentRequest));
    //assert
    expect(result, Right(commentResponse));
    // verify
    verify(()=> mockCommentRepository.createComment(commentRequest)).called(1);
    verifyNoMoreInteractions(mockCommentRepository);
  });
}