import 'package:dartz/dartz.dart';
import 'package:template/core/error/exception.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/data/datasources/comment_remote_data_source.dart';
import 'package:template/data/models/comment_request_model.dart';
import 'package:template/domain/entities/comment.dart';
import 'package:template/domain/repositories/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {

  final CommentRemoteDataSource commentRemoteDataSource;

  CommentRepositoryImpl(this.commentRemoteDataSource);

  @override
  Future<Either<Failure, Comment>> createComment(CommentRequestModel request) async{
    try {
      return Right(await commentRemoteDataSource.createComment(request));
    } on ServerException {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteComment(int id) async{
    try {
      return Right(await commentRemoteDataSource.deleteComment(id));
    } on ServerException {
    return const Left(ServerFailure());
    } on NotFoundException {
    return const Left(NotFoundFailure());
    }
  }

  @override
  Future<Either<Failure, List<Comment>>> findCommentsByProductId(int id) async{
    try {
      return Right(await commentRemoteDataSource.findCommentsByProductId(id));
    } on ServerException {
      return const Left(ServerFailure());
    } on NotFoundException {
      return const Left(NotFoundFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> reportComment(int id) async{
    try {
      return Right(await commentRemoteDataSource.reportComment(id));
    } on ServerException {
    return const Left(ServerFailure());
    } on NotFoundException {
    return const Left(NotFoundFailure());
    }
  }

  @override
  Future<Either<Failure, Comment>> updateComment(Comment request) async{
    try {
      return Right(await commentRemoteDataSource.updateComment(request));
    } on ServerException {
    return const Left(ServerFailure());
    } on NotFoundException {
    return const Left(NotFoundFailure());
    }
  }

}