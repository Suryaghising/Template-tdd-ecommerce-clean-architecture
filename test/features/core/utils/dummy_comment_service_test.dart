import 'package:flutter_test/flutter_test.dart';
import 'package:template/core/error/exception.dart';
import 'package:template/core/services/dummy_comment_service.dart';

void main() {
  late DummyCommentService dummyCommentService;

  setUp(() {
    dummyCommentService = DummyCommentServiceImpl();
  });

  List<dynamic> expectedComments = [
    {'id': 1, 'user_id': 1, 'product_id': 1, 'content': 'Content 1', 'created_at': '2022-01-02'},
    {'id': 2, 'user_id': 1, 'product_id': 1, 'content': 'Content 2', 'created_at': '2022-01-03'},
    {'id': 3, 'user_id': 2, 'product_id': 2, 'content': 'Content 3', 'created_at': '2022-01-04'},
  ];

  group('getCommentsByProductId', () {
    test('should return a list of dummy comments by product id', () {
      // Act
      final comments = dummyCommentService.findCommentsByProductId(1);

      // Assert
      expect(comments.length, equals(2));
    });

  });

  group('createComment', () {
    test('should add a new comment to the list', () {
      // Arrange
      final newComment = {'id': 4, 'user_id': 2, 'product_id': 2, 'content': 'Content 4', 'created_at': '2022-01-04'};
      final initialComments = dummyCommentService.getAllComments();

      // Act
      dummyCommentService.createComment(newComment);
      final commentsAfterAddition = dummyCommentService.getAllComments();
      final addedComment = commentsAfterAddition.firstWhere((comment) => comment['id'] == 4);
      // Assert
      expect(addedComment, isNotNull);
      expect(commentsAfterAddition.length, equals(initialComments.length + 1));
    });

  });

  group('updateComment', () {
    test('should update the comment with matching id', () {
      // Arrange
      final updatedComment = {'id': 2, 'user_id': 1, 'product_id': 1, 'content': 'Updated content', 'created_at': '2022-01-03'};

      // Act
      dummyCommentService.updateComment(updatedComment);
      final updatedCommentFromService = dummyCommentService.getCommentById(2);

      // Assert
      expect(updatedCommentFromService, equals(updatedComment));
    });

    test('should throw NotFoundException for non-existent id', () {
      // Arrange
      final nonExistentComment =  {'id': 10, 'user_id': 2, 'product_id': 2, 'content': 'Content 10', 'created_at': '2022-01-04'};

      // Act & Assert
      expect(() => dummyCommentService.updateComment(nonExistentComment), throwsA(isA<NotFoundException>()));
    });
  });


  group('deleteComment', () {
    test('should remove the comment with matching id', () {
      // Arrange
      int id = 2;
      final comments = dummyCommentService.getAllComments();
      // Act
      dummyCommentService.deleteComment(id);
      final commentsAfterDeletion = dummyCommentService.getAllComments();
      int index = commentsAfterDeletion.indexWhere((element) => element['id'] as int == id);
      // Assert
      expect(index, -1);
      expect(commentsAfterDeletion.length, comments.length-1);
    });


    test('should throw an exception for non-existent id', () {
      // Act & Assert
      expect(() => dummyCommentService.deleteComment(10), throwsA(isA<NotFoundException>()));
    });
  });

  group('reportComment', () {
    test('should remove the comment with matching id', () {
      // Arrange
      int id = 2;
      final comments = dummyCommentService.getAllComments();
      // Act
      dummyCommentService.reportComment(id);
      final commentsAfterDeletion = dummyCommentService.getAllComments();
      int index = commentsAfterDeletion.indexWhere((element) => element['id'] as int == id);
      // Assert
      expect(index, -1);
      expect(commentsAfterDeletion.length, comments.length-1);
    });


    test('should throw an exception for non-existent id', () {
      // Act & Assert
      expect(() => dummyCommentService.reportComment(10), throwsA(isA<NotFoundException>()));
    });
  });
}
