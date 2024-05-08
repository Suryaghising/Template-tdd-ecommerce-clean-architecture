part of 'add_update_comment_cubit.dart';

@immutable
abstract class AddUpdateCommentState {}

class AddUpdateCommentInitial extends AddUpdateCommentState {}

class AddUpdateCommentLoading extends AddUpdateCommentState {}

class AddUpdateCommentSuccess extends AddUpdateCommentState {
  final Comment comment;

  AddUpdateCommentSuccess(this.comment);
}

class AddUpdateCommentFailure extends AddUpdateCommentState {
  final Failure failure;

  AddUpdateCommentFailure(this.failure);
}