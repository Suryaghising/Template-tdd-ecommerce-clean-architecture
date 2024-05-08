import 'package:dartz/dartz.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/repositories/comment_repository.dart';

class DeleteCommentUsecase extends UseCase<bool, Params> {

  final CommentRepository commentRepository;

  DeleteCommentUsecase(this.commentRepository);

  @override
  Future<Either<Failure, bool>?> call(Params params) async{
    return await commentRepository.deleteComment(params.data);
  }

}