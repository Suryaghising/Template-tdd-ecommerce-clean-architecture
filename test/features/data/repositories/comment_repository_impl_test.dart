import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/error/exception.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/data/datasources/comment_remote_data_source.dart';
import 'package:template/data/models/comment_model.dart';
import 'package:template/data/models/comment_request_model.dart';
import 'package:template/data/repositories/comment_repository_impl.dart';
import 'package:template/domain/entities/comment.dart';
import 'package:template/domain/repositories/comment_repository.dart';

class MockCommentRemoteDataSource extends Mock implements CommentRemoteDataSource {}

void main() {
  late MockCommentRemoteDataSource mockCommentRemoteDataSource;
  late CommentRepository commentRepository;

  setUp(() {
    mockCommentRemoteDataSource = MockCommentRemoteDataSource();
    commentRepository = CommentRepositoryImpl(mockCommentRemoteDataSource);
  });

  group('fetchCommentsByProductId', () {

    List<CommentModel> commentModelList = [
      CommentModel(id: 1, userId: 1, productId: 1, content: 'Test content', createdAt: DateTime(2022, 1, 2)),
    ];
    List<Comment> comments = commentModelList;

    test('should return comments by product id when the call to remote data source is success', () async{
      // arrange
      when(() => mockCommentRemoteDataSource.findCommentsByProductId(any()))
          .thenAnswer((_) async => commentModelList);
      // act
      final result = await commentRepository.findCommentsByProductId(1);
      // assert
      expect(result, Right(comments));
      verify(() => mockCommentRemoteDataSource.findCommentsByProductId(any())).called(1);
      verifyNoMoreInteractions(mockCommentRemoteDataSource);
    });

    test('should return failure when the call to remote data source is failed', () async{
      // arrange
      when(() => mockCommentRemoteDataSource.findCommentsByProductId(any()))
          .thenThrow(ServerException());
      // act
      final result = await commentRepository.findCommentsByProductId(1);
      // assert
      expect(result, const Left(ServerFailure()));
    });
  });


  group('addComment', () {


    final commentRequest = CommentRequestModel(userId: 1, productId: 1, content: 'Test content', createdAt: DateTime(2022, 1, 2));
    final commentModel = CommentModel(id: 1, userId: 1, productId: 1, content: 'Test content', createdAt: DateTime(2022, 1, 2));
    Comment comment = commentModel;

    test('should add and return comment with id when the call to remote data source is success', () async{
      // arrange
      when(() => mockCommentRemoteDataSource.createComment(commentRequest))
          .thenAnswer((_) async => commentModel);
      // act
      final result = await commentRepository.createComment(commentRequest);
      // assert
      expect(result, Right(comment));
      verify(() => mockCommentRemoteDataSource.createComment(commentRequest)).called(1);
      verifyNoMoreInteractions(mockCommentRemoteDataSource);
    });

    test('should return failure when the call to remote data source is failed', () async{
      // arrange
      when(() => mockCommentRemoteDataSource.createComment(commentRequest))
          .thenThrow(ServerException());
      // act
      final result = await commentRepository.createComment(commentRequest);
      // assert
      expect(result, const Left(ServerFailure()));
    });
  });

  group('updateComment', () {
    final request = Comment(id: 1, userId: 1, productId: 1, content: 'Test content', createdAt: DateTime(2022, 1, 2));
    final commentModel = Comment(id: 1, userId: 1, productId: 1, content: 'Updated content', createdAt: DateTime(2022, 1, 2));
    Comment expectedResponse = commentModel;

    test('should update and return comment when the call to remote data source is success', () async{
      // arrange
      when(() => mockCommentRemoteDataSource.updateComment(request))
          .thenAnswer((_) async => commentModel);
      // act
      final result = await commentRepository.updateComment(request);
      // assert
      expect(result, Right(expectedResponse));
      verify(() => mockCommentRemoteDataSource.updateComment(request)).called(1);
      verifyNoMoreInteractions(mockCommentRemoteDataSource);
    });

    test('should return failure when the call to remote data source is failed', () async{
      // arrange
      when(() => mockCommentRemoteDataSource.updateComment(request))
          .thenThrow(ServerException());
      // act
      final result = await commentRepository.updateComment(request);
      // assert
      expect(result, const Left(ServerFailure()));
    });

    test('should return failure when the comment with given id is not found', () async{
      // arrange
      when(() => mockCommentRemoteDataSource.updateComment(request))
          .thenThrow(NotFoundException());
      // act
      final result = await commentRepository.updateComment(request);
      // assert
      expect(result, const Left(NotFoundFailure()));
    });
  });

  group('deleteComment', () {

    int id = 1;

    test('should return true when the call to remote data source is success', () async{
      // arrange
      when(() => mockCommentRemoteDataSource.deleteComment(any()))
          .thenAnswer((_) async => true);
      // act
      final result = await commentRepository.deleteComment(id);
      // assert
      expect(result, const Right(true));
      verify(() => mockCommentRemoteDataSource.deleteComment(any())).called(1);
      verifyNoMoreInteractions(mockCommentRemoteDataSource);
    });

    test('should return failure when the call to remote data source is failed', () async{
      // arrange
      when(() => mockCommentRemoteDataSource.deleteComment(any()))
          .thenThrow(ServerException());
      // act
      final result = await commentRepository.deleteComment(id);
      // assert
      expect(result, const Left(ServerFailure()));
    });

    test('should return failure when the comment with given id is not found', () async{
      // arrange
      when(() => mockCommentRemoteDataSource.deleteComment(any()))
          .thenThrow(NotFoundException());
      // act
      final result = await commentRepository.deleteComment(id);
      // assert
      expect(result, const Left(NotFoundFailure()));
    });
  });

  group('reportComment', () {

    int id = 1;

    test('should return true when the call to remote data source is success', () async{
      // arrange
      when(() => mockCommentRemoteDataSource.reportComment(any()))
          .thenAnswer((_) async => true);
      // act
      final result = await commentRepository.reportComment(id);
      // assert
      expect(result, const Right(true));
      verify(() => mockCommentRemoteDataSource.reportComment(any())).called(1);
      verifyNoMoreInteractions(mockCommentRemoteDataSource);
    });

    test('should return failure when the call to remote data source is failed', () async{
      // arrange
      when(() => mockCommentRemoteDataSource.reportComment(any()))
          .thenThrow(ServerException());
      // act
      final result = await commentRepository.reportComment(id);
      // assert
      expect(result, const Left(ServerFailure()));
    });

    test('should return failure when the comment with given id is not found', () async{
      // arrange
      when(() => mockCommentRemoteDataSource.reportComment(any()))
          .thenThrow(NotFoundException());
      // act
      final result = await commentRepository.reportComment(id);
      // assert
      expect(result, const Left(NotFoundFailure()));
    });
  });
}