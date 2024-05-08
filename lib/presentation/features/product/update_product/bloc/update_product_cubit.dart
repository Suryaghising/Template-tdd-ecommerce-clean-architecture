import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:template/domain/usecases/products/update_product_usecase.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../domain/entities/product.dart';

part 'update_product_state.dart';

class UpdateProductCubit extends Cubit<UpdateProductState> {
  UpdateProductCubit(this.updateProductUsecase) : super(UpdateProductInitial());

  final UpdateProductUsecase updateProductUsecase;

  void updateProduct(String name, String price, String description, String imageUrl, Product product) async{
    emit(UpdateProductLoading());
    if (name.isEmpty) {
      emit(UpdateProductFailure(const ValidationFailure('Name is required')));
    } else if (price.isEmpty) {
      emit(UpdateProductFailure(const ValidationFailure('Price is required')));
    } else if (description.isEmpty) {
      emit(UpdateProductFailure(
          const ValidationFailure('Description is required')));
    } else if (imageUrl.isEmpty) {
      emit(UpdateProductFailure(const ValidationFailure('Image url is required')));
    } else {
      final failureOrAddProduct = await updateProductUsecase(Params(
          data: Product(id: product.id, name: name, price: double.parse(price), description: description, imageUrl: imageUrl)));
      failureOrAddProduct!.fold((failure) => emit(UpdateProductFailure(failure)),
              (product) => emit(UpdateProductSuccess(product)));
    }
  }
}
