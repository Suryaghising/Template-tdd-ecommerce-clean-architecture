import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/error/exception.dart';
import 'package:template/core/services/dummy_comment_service.dart';
import 'package:template/data/datasources/comment_remote_data_source.dart';
import 'package:template/data/models/comment_model.dart';
import 'package:template/data/models/comment_request_model.dart';
import 'package:template/domain/entities/comment.dart';

import '../../../fixtures/fixture_reader.dart';

class MockDummyCommentService extends Mock implements DummyCommentService {}

void main() {
  late CommentRemoteDataSource commentRemoteDataSource;
  late MockDummyCommentService mockDummyCommentService;

  setUp(() {
    mockDummyCommentService = MockDummyCommentService();
    commentRemoteDataSource = CommentRemoteDataSourceImpl(mockDummyCommentService);
  });

  group('fetchCommentsByProductId', () {

    final commentModels = [
      CommentModel(id: 1, userId: 1, productId: 1, content: 'Test content', createdAt: DateTime(2022, 1, 2))
    ];

    final List<dynamic> commentListJson = jsonDecode(fixture('comment_list.json'));

    test('should return all commentsByProductId from dummy data', () async{
      // arrange
      when(() => mockDummyCommentService.findCommentsByProductId(any()))
          .thenAnswer((_) => commentListJson);
      // act
      final result = await commentRemoteDataSource.findCommentsByProductId(1);
      // assert
      expect(result, commentModels);
    });
  });

  group('addComment', () {

    Map<String, dynamic> response = jsonDecode(fixture('comment.json'));
    final request = CommentRequestModel(userId: 1, productId: 1, content: 'Test content', createdAt: DateTime(2022, 1, 2));
    CommentModel expectedResult = CommentModel.fromJson(jsonDecode(fixture('comment.json')));

    test('should return comment with id after adding data into dummy data', () async{
      // arrange
      when(() => mockDummyCommentService.createComment(CommentRequestModel.toJson(request)))
          .thenAnswer((_) => response);
      // act
      final result = await commentRemoteDataSource.createComment(request);
      // assert
      expect(result, expectedResult);
    });
  });

  group('updateComment', () {
    Map<String, dynamic> response = jsonDecode(fixture('comment.json'));
    final commentRequest = Comment(id: 1, userId: 1, productId: 1, content: 'Test content', createdAt: DateTime(2022, 1, 2));
    CommentModel commentModelRequest = CommentModel(id: commentRequest.id, userId: commentRequest.userId, productId: commentRequest.productId, content: commentRequest.content, createdAt: commentRequest.createdAt);
    CommentModel expectedResult = CommentModel.fromJson(jsonDecode(fixture('comment.json')));

    test('should update and return comment after updating data into dummy data', () async{
      // arrange
      when(() => mockDummyCommentService.updateComment(CommentModel.toJson(commentModelRequest)))
          .thenAnswer((_) => response);
      // act
      final result = await commentRemoteDataSource.updateComment(commentRequest);
      // assert
      expect(result, expectedResult);
    });

    test('should throw not found exception when comment with matching id is not found', () async {
      // arrange
      when(() => mockDummyCommentService.updateComment(CommentModel.toJson(commentModelRequest)))
          .thenThrow(NotFoundException());
      // act & assert
      expect(() async => await commentRemoteDataSource.updateComment(commentRequest), throwsA(isA<NotFoundException>()));
    });
  });

  group('deleteComment', () {
    int id = 1;

    test('should return true after deleting comment from dummy data', () async{
      // arrange
      when(() => mockDummyCommentService.deleteComment(any()))
          .thenAnswer((_) {});
      // act
      final result = await commentRemoteDataSource.deleteComment(id);
      // assert
      expect(result, true);
    });

    test('should throw not found exception when comment with matching id is not found', () async {
      // arrange
      when(() => mockDummyCommentService.deleteComment(any()))
          .thenThrow(NotFoundException());
      // act & assert
      expect(() async => await commentRemoteDataSource.deleteComment(id), throwsA(isA<NotFoundException>()));
    });
  });

  group('reportComment', () {
    int id = 1;

    test('should return true after deleting comment from dummy data', () async{
      // arrange
      when(() => mockDummyCommentService.reportComment(any()))
          .thenAnswer((_) {});
      // act
      final result = await commentRemoteDataSource.reportComment(id);
      // assert
      expect(result, true);
    });

    test('should throw not found exception when comment with matching id is not found', () async {
      // arrange
      when(() => mockDummyCommentService.reportComment(any()))
          .thenThrow(NotFoundException());
      // act & assert
      expect(() async => await commentRemoteDataSource.reportComment(id), throwsA(isA<NotFoundException>()));
    });
  });
}