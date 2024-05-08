import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/entities/comment.dart';
import 'package:template/domain/repositories/comment_repository.dart';
import 'package:template/domain/usecases/comments/find_comments_by_product_id_usecase.dart';

class MockCommentRepository extends Mock implements CommentRepository {}

void main() {
  late MockCommentRepository mockCommentRepository;
  late FindCommentsByProductIdUsecase findCommentsByProductIdUsecase;

  setUpAll(() => {TestWidgetsFlutterBinding.ensureInitialized()});

  setUp(() {
    mockCommentRepository = MockCommentRepository();
    findCommentsByProductIdUsecase = FindCommentsByProductIdUsecase(mockCommentRepository);
  });

  final List<Comment> commentList = [
     Comment(id: 1, userId: 1, productId: 1, content: 'Test Content', createdAt: DateTime(2022, 1, 2)),
  ];

  test('should get comments by id from mock api request', () async{
    // arrange
    when(() => mockCommentRepository.findCommentsByProductId(any()))
        .thenAnswer((_) async => Right(commentList));
    // act
    final result = await findCommentsByProductIdUsecase(const Params(data: 1));
    //assert
    expect(result, Right(commentList));
    // verify
    verify(() => mockCommentRepository.findCommentsByProductId(any())).called(1);
    verifyNoMoreInteractions(mockCommentRepository);
  });

}