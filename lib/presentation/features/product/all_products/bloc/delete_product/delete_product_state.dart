part of 'delete_product_cubit.dart';

@immutable
abstract class DeleteProductState {}

class DeleteProductInitial extends DeleteProductState {}

class DeleteProductSuccess extends DeleteProductState {}

class DeleteProductFailure extends DeleteProductState {
  final Failure failure;

  DeleteProductFailure(this.failure);
}