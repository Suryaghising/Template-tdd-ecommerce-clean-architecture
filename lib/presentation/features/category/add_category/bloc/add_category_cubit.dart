import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/data/models/category_request_model.dart';
import 'package:template/domain/entities/category.dart';
import 'package:template/domain/usecases/categories/add_category_usecase.dart';

part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit(this.addCategoryUsecase) : super(AddCategoryInitial());

  final AddCategoryUsecase addCategoryUsecase;

  addCategory(String name, String description) async{
    emit(AddCategoryLoading());
    if(name.isEmpty) {
      emit(AddCategoryFailure(const ValidationFailure('Name is empty')));
    } else if(description.isEmpty) {
      emit(AddCategoryFailure(const ValidationFailure('Description is empty')));
    }else {
      final failureOrAddCategory = await addCategoryUsecase(Params(data: CategoryRequestModel(name: name, description: description)));
      failureOrAddCategory!.fold((failure) => emit(AddCategoryFailure(failure)), (category) => emit(AddCategorySuccess(category: category)));
    }
  }
}
