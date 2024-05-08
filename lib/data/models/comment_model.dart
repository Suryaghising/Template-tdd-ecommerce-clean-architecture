import 'package:template/domain/entities/comment.dart';

class CommentModel extends Comment {
  const CommentModel(
      {required super.id,
      required super.userId,
      required super.productId,
      required super.content,
      required super.createdAt});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        id: json['id'],
        userId: json['user_id'],
        productId: json['product_id'],
        content: json['content'],
        createdAt: DateTime.parse(json['created_at']));
  }

  static toJson(CommentModel request) {
    return {
      'id': request.id,
      'user_id': request.userId,
      'product_id': request.productId,
      'content': request.content,
      'created_at': request.createdAt.toString()
    };
  }
}
