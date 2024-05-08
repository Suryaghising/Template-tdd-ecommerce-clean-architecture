part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categoryList;

  CategoryLoaded({required this.categoryList});
}

class CategoryFailure extends CategoryState {
  final Failure failure;

  CategoryFailure(this.failure);
}