part of 'update_product_cubit.dart';

@immutable
abstract class UpdateProductState {}

class UpdateProductInitial extends UpdateProductState {}

class UpdateProductLoading extends UpdateProductState {}

class UpdateProductFailure extends UpdateProductState {
  final Failure failure;

  UpdateProductFailure(this.failure);
}

class UpdateProductSuccess extends UpdateProductState {
  final Product product;

  UpdateProductSuccess(this.product);
}