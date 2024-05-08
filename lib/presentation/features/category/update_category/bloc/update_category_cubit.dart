import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/entities/category.dart';
import 'package:template/domain/usecases/categories/update_category_usecase.dart';

part 'update_category_state.dart';

class UpdateCategoryCubit extends Cubit<UpdateCategoryState> {
  UpdateCategoryCubit(this.updateCategoryUsecase)
      : super(UpdateCategoryInitial());

  final UpdateCategoryUsecase updateCategoryUsecase;

  updateCategory(String name, String description, Category category) async {
    emit(UpdateCategoryLoading());
    if (name.isEmpty) {
      emit(UpdateCategoryFailure(const ValidationFailure('Name is required')));
    } else if (description.isEmpty) {
      emit(UpdateCategoryFailure(
          const ValidationFailure('Description is required')));
    } else {
      final updatedCategory =
          Category(id: category.id, name: name, description: description);
      final failureOrCategoryUpdate =
          await updateCategoryUsecase(Params(data: updatedCategory));
      failureOrCategoryUpdate!.fold(
          (failure) => emit(UpdateCategoryFailure(failure)),
          (response) => emit(UpdateCategorySuccess(response)));
    }
  }
}
