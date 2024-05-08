import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/usecases/categories/delete_category_usecase.dart';

part 'delete_category_state.dart';

class DeleteCategoryCubit extends Cubit<DeleteCategoryState> {
  DeleteCategoryCubit(this.deleteCategoryUsecase)
      : super(DeleteCategoryInitial());

  final DeleteCategoryUsecase deleteCategoryUsecase;

  deleteCategory(int id) async {
    final failureOrDeleteCategory =
        await deleteCategoryUsecase(Params(data: id));
    failureOrDeleteCategory!.fold(
        (failure) => emit(DeleteCategoryFailure(failure)),
        (_) => emit(DeleteCategorySuccess()));
  }
}
