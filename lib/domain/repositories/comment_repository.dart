import 'package:dartz/dartz.dart';
import 'package:template/data/models/comment_request_model.dart';
import 'package:template/domain/entities/comment.dart';

import '../../core/error/failures.dart';

abstract class CommentRepository {
  Future<Either<Failure, Comment>> createComment(CommentRequestModel request);
  Future<Either<Failure, List<Comment>>> findCommentsByProductId(int id);
  Future<Either<Failure, Comment>> updateComment(Comment request);
  Future<Either<Failure, bool>> deleteComment(int id);
  Future<Either<Failure, bool>>reportComment(int id);
}