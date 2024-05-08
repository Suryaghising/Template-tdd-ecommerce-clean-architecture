import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final int id;
  final int userId;
  final int productId;
  final String content;
  final DateTime createdAt;

  const Comment({required this.id, required this.userId, required this.productId, required this.content, required this.createdAt});

  @override
  List<Object?> get props => [id, userId, productId, content, createdAt];
}