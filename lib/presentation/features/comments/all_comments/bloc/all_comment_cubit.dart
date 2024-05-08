import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/usecases/comments/delete_comment_usecase.dart';
import 'package:template/domain/usecases/comments/find_comments_by_product_id_usecase.dart';
import 'package:template/domain/usecases/comments/report_comment_usecase.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../domain/entities/comment.dart';

part 'all_comment_state.dart';

class AllCommentCubit extends Cubit<AllCommentState> {
  AllCommentCubit(this.findCommentsByProductIdUsecase, this.deleteCommentUsecase, this.reportCommentUsecase)
      : super(AllCommentInitial());

  final FindCommentsByProductIdUsecase findCommentsByProductIdUsecase;
  final DeleteCommentUsecase deleteCommentUsecase;
  final ReportCommentUsecase reportCommentUsecase;

  getCommentsByProductId(int id) async {
    emit(AllCommentsLoading());
    final failureOrAllComments =
        await findCommentsByProductIdUsecase(Params(data: id));
    failureOrAllComments!.fold((failure) => emit(AllCommentsFailure(failure)),
        (commentList) => emit(AllCommentsLoaded(commentList)));
  }

  deleteComment(int id) async{
    emit(AllCommentsLoading());
    final failureOrDeleteComment = await deleteCommentUsecase(Params(data: id));
    failureOrDeleteComment!.fold((failure) => emit(CommentDeleteReportFailure(failure)), (_) => emit(CommentDeleteReportSuccess()));
  }

  reportComment(int id) async{
    emit(AllCommentsLoading());
    final failureOrDeleteComment = await reportCommentUsecase(Params(data: id));
    failureOrDeleteComment!.fold((failure) => emit(CommentDeleteReportFailure(failure)), (_) => emit(CommentDeleteReportSuccess()));
  }
}
