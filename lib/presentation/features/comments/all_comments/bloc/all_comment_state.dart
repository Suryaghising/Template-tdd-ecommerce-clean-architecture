part of 'all_comment_cubit.dart';

@immutable
abstract class AllCommentState {}

class AllCommentInitial extends AllCommentState {}

class AllCommentsLoaded extends AllCommentState {
  final List<Comment> commentList;

  AllCommentsLoaded(this.commentList);
}

class AllCommentsFailure extends AllCommentState {
  final Failure failure;

  AllCommentsFailure(this.failure);
}

class AllCommentsLoading extends AllCommentState {}

class CommentDeleteReportFailure extends AllCommentState {
  final Failure failure;

  CommentDeleteReportFailure(this.failure);
}

class CommentDeleteReportSuccess extends AllCommentState {}