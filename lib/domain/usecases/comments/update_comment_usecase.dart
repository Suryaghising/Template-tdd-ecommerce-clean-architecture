import 'package:dartz/dartz.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/repositories/comment_repository.dart';

import '../../entities/comment.dart';

class UpdateCommentUsecase extends UseCase<Comment, Params> {

  final CommentRepository commentRepository;

  UpdateCommentUsecase(this.commentRepository);

  @override
  Future<Either<Failure, Comment>?> call(Params params) async{
    return await commentRepository.updateComment(params.data);
  }

}