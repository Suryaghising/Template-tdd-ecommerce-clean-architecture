import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/usecases/usecase.dart';

import '../../../../../domain/entities/category.dart';
import '../../../../../domain/usecases/categories/fetch_category_usecase.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.fetchCategoryUsecase) : super(CategoryInitial());

  final FetchCategoryUsecase fetchCategoryUsecase;

  getCategories() async {
    emit(CategoryInitial());
    final failureOrCategories = await fetchCategoryUsecase(NoParams());
    failureOrCategories.fold((failure) => emit(CategoryFailure(failure)),
        (categoryList) => emit(CategoryLoaded(categoryList: categoryList)));
  }
}
