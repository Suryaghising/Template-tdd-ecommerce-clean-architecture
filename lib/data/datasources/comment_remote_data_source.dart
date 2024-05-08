import 'package:template/core/services/dummy_comment_service.dart';
import 'package:template/data/models/comment_model.dart';
import 'package:template/data/models/comment_request_model.dart';
import 'package:template/domain/entities/comment.dart';

abstract class CommentRemoteDataSource {
  Future<List<Comment>> findCommentsByProductId(int id);
  Future<Comment> createComment(CommentRequestModel request);
  Future<Comment> updateComment(Comment request);
  Future<bool> deleteComment(int id);
  Future<bool> reportComment(int id);
}

class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {

  final DummyCommentService dummyCommentService;

  CommentRemoteDataSourceImpl(this.dummyCommentService);

  @override
  Future<Comment> createComment(CommentRequestModel request) async{
    final response = dummyCommentService.createComment(CommentRequestModel.toJson(request));
    return CommentModel.fromJson(response);
  }

  @override
  Future<bool> deleteComment(int id) async{
    dummyCommentService.deleteComment(id);
    return true;
  }

  @override
  Future<List<Comment>> findCommentsByProductId(int id) async{
    final response = dummyCommentService.findCommentsByProductId(id);
    return response.map((e) => CommentModel.fromJson(e)).toList();
  }

  @override
  Future<bool> reportComment(int id) async{
    dummyCommentService.reportComment(id);
    return true;
  }

  @override
  Future<Comment> updateComment(Comment request) async{
    final commentModel = CommentModel(id: request.id, userId: request.userId, productId: request.productId, content: request.content, createdAt: request.createdAt);
    final response = dummyCommentService.updateComment(CommentModel.toJson(commentModel));
    return CommentModel.fromJson(response);
  }

}