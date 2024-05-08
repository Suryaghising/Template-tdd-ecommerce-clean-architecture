import 'package:dartz/dartz.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/entities/comment.dart';
import 'package:template/domain/repositories/comment_repository.dart';

class FindCommentsByProductIdUsecase extends UseCase<List<Comment>, Params> {

  final CommentRepository commentRepository;

  FindCommentsByProductIdUsecase(this.commentRepository);

  @override
  Future<Either<Failure, List<Comment>>?> call(Params params) async{
    return await commentRepository.findCommentsByProductId(params.data);
  }

}