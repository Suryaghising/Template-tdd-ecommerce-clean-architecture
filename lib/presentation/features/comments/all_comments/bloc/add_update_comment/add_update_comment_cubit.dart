import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/data/models/comment_request_model.dart';
import 'package:template/domain/entities/comment.dart';
import 'package:template/domain/usecases/comments/create_comment_usecase.dart';
import 'package:template/domain/usecases/comments/update_comment_usecase.dart';

import '../../../../../../core/error/failures.dart';

part 'add_update_comment_state.dart';

class AddUpdateCommentCubit extends Cubit<AddUpdateCommentState> {
  AddUpdateCommentCubit(this.addCommentUsecase, this.updateCommentUsecase) : super(AddUpdateCommentInitial());

  final CreateCommentUsecase addCommentUsecase;
  final UpdateCommentUsecase updateCommentUsecase;

  addComment(int productId, String userId, String comment) async {
    emit(AddUpdateCommentLoading());
    final failureOrAddComment = await addCommentUsecase(Params(
        data: CommentRequestModel(
            userId: int.parse(userId),
            content: comment,
            productId: productId,
            createdAt: DateTime.now())));
    failureOrAddComment!.fold((failure) => emit(AddUpdateCommentFailure(failure)),
        (comment) => emit(AddUpdateCommentSuccess(comment)));
  }

  updateComment(String userId, String content, Comment comment) async{
    emit(AddUpdateCommentLoading());
    final failureOrUpdateComment = await updateCommentUsecase(Params(data: Comment(id: comment.id, createdAt: comment.createdAt, productId: comment.productId, content: content, userId: int.parse(userId))));
    failureOrUpdateComment!.fold((failure) => emit(AddUpdateCommentFailure(failure)),
            (comment) => emit(AddUpdateCommentSuccess(comment)));
  }
}
