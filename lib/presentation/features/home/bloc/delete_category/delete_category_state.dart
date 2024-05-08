part of 'delete_category_cubit.dart';

@immutable
abstract class DeleteCategoryState {}

class DeleteCategoryInitial extends DeleteCategoryState {}

class DeleteCategorySuccess extends DeleteCategoryState {}

class DeleteCategoryFailure extends DeleteCategoryState {
  final Failure failure;

  DeleteCategoryFailure(this.failure);
}