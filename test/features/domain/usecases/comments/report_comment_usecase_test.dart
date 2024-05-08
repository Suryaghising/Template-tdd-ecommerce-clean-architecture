import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/repositories/comment_repository.dart';
import 'package:template/domain/usecases/comments/report_comment_usecase.dart';

class MockCommentRepository extends Mock implements CommentRepository {}

void main() {

  late MockCommentRepository mockCommentRepository;
  late ReportCommentUsecase reportCommentUsecase;

  setUp(() {
    mockCommentRepository = MockCommentRepository();
    reportCommentUsecase = ReportCommentUsecase(mockCommentRepository);
  });

  int commentId = 1;

  test('should report comment on mock api', () async{
    // arrange
    when(() => mockCommentRepository.reportComment(any()))
        .thenAnswer((invocation) async => const Right(true));
    // act
    final result = await reportCommentUsecase(Params(data: commentId));
    // assert
    expect(result, const Right(true));
    verify(() => mockCommentRepository.reportComment(any())).called(1);
    verifyNoMoreInteractions(mockCommentRepository);
  });
}