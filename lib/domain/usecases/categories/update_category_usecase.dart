import 'package:dartz/dartz.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/repositories/category_repository.dart';

import '../../entities/category.dart';

class UpdateCategoryUsecase extends UseCase<Category, Params> {

  final CategoryRepository categoryRepository;

  UpdateCategoryUsecase(this.categoryRepository);

  @override
  Future<Either<Failure, Category>?> call(Params params) async{
    return await categoryRepository.updateCategory(params.data);
  }


}