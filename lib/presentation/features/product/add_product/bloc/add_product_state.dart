part of 'add_product_cubit.dart';

@immutable
abstract class AddProductState {}

class AddProductInitial extends AddProductState {}

class AddProductLoading extends AddProductState {}

class AddProductSuccess extends AddProductState {
  final Product product;

  AddProductSuccess(this.product);
}

class AddProductFailure extends AddProductState {
  final Failure failure;

  AddProductFailure(this.failure);
}