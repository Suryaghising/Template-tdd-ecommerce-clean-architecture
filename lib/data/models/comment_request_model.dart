import 'package:template/data/models/product_request_model.dart';

class CommentRequestModel {
  final int userId;
  final int productId;
  final String content;
  final DateTime createdAt;

  CommentRequestModel({required this.userId, required this.productId, required this.content, required this.createdAt});

  static toJson(CommentRequestModel commentRequestModel) {
    return {
      'user_id': commentRequestModel.userId,
      'product_id': commentRequestModel.productId,
      'content': commentRequestModel.content,
      'created_at': commentRequestModel.createdAt.toString()
    };
  }
}