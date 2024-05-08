import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/data/models/product_request_model.dart';
import 'package:template/domain/entities/product.dart';
import 'package:template/domain/usecases/products/add_product_usecase.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(this.addProductUsecase) : super(AddProductInitial());

  final AddProductUsecase addProductUsecase;

  addProduct(
      String name, String price, String description, String imageUrl) async {
    emit(AddProductLoading());
    if (name.isEmpty) {
      emit(AddProductFailure(const ValidationFailure('Name is required')));
    } else if (price.isEmpty) {
      emit(AddProductFailure(const ValidationFailure('Price is required')));
    } else if (description.isEmpty) {
      emit(AddProductFailure(
          const ValidationFailure('Description is required')));
    } else if (imageUrl.isEmpty) {
      emit(AddProductFailure(const ValidationFailure('Image url is required')));
    } else {
      final failureOrAddProduct = await addProductUsecase(Params(
          data: ProductRequestModel(
              name: name,
              description: description,
              imageUrl: imageUrl,
              price: double.parse(price))));
      failureOrAddProduct!.fold((failure) => emit(AddProductFailure(failure)),
          (product) => emit(AddProductSuccess(product)));
    }
  }
}
