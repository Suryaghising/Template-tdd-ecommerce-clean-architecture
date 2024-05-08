part of 'all_products_cubit.dart';

@immutable
abstract class AllProductsState {}

class AllProductsInitial extends AllProductsState {}

class AllProductsLoading extends AllProductsState {}

class AllProductsLoaded extends AllProductsState {
  final List<Product> productList;

  AllProductsLoaded(this.productList);
}

class AllProductsFailure extends AllProductsState {
  final Failure failure;

  AllProductsFailure(this.failure);
}