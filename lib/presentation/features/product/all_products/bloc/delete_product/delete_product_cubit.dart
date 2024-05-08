import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/usecases/products/delete_product_usecase.dart';

part 'delete_product_state.dart';

class DeleteProductCubit extends Cubit<DeleteProductState> {
  DeleteProductCubit(this.deleteProductUsecase) : super(DeleteProductInitial());

  final DeleteProductUsecase deleteProductUsecase;

  deleteProduct(int id) async {
    emit(DeleteProductInitial());
    final failureOrDeleteProduct = await deleteProductUsecase(Params(data: id));
    failureOrDeleteProduct!.fold(
        (failure) => emit(DeleteProductFailure(failure)),
        (_) => emit(DeleteProductSuccess()));
  }
}
