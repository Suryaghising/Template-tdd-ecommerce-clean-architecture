part of 'add_category_cubit.dart';

@immutable
abstract class AddCategoryState {}

class AddCategoryInitial extends AddCategoryState {}

class AddCategoryLoading extends AddCategoryState {}

class AddCategorySuccess extends AddCategoryState {
  final Category category;

  AddCategorySuccess({required this.category});
}

class AddCategoryFailure extends AddCategoryState {
  final Failure failure;

  AddCategoryFailure(this.failure);
}