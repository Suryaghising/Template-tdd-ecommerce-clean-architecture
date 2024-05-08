import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/usecases/products/fetch_all_products_usecase.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../domain/entities/product.dart';

part 'all_products_state.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  AllProductsCubit(this.fetchAllProductsUsecase) : super(AllProductsInitial());

  final FetchAllProductsUsecase fetchAllProductsUsecase;

  getAllProducts() async {
    emit(AllProductsLoading());
    final failureOrProductList = await fetchAllProductsUsecase(NoParams());
    failureOrProductList!.fold((failure) => emit(AllProductsFailure(failure)),
        (productList) => emit(AllProductsLoaded(productList)));
  }
}
