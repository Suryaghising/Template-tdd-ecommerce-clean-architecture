part of 'update_category_cubit.dart';

@immutable
abstract class UpdateCategoryState {}

class UpdateCategoryInitial extends UpdateCategoryState {}

class UpdateCategoryLoading extends UpdateCategoryState {}

class UpdateCategorySuccess extends UpdateCategoryState {
  final Category category;

  UpdateCategorySuccess(this.category);
}

class UpdateCategoryFailure extends UpdateCategoryState {
  final Failure failure;

  UpdateCategoryFailure(this.failure);
}
