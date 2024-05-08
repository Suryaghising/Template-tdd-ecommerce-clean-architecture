import 'package:dartz/dartz.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/entities/category.dart';
import 'package:template/domain/repositories/category_repository.dart';

class AddCategoryUsecase extends UseCase<Category, Params> {

  final CategoryRepository categoryRepository;

  AddCategoryUsecase(this.categoryRepository);

  @override
  Future<Either<Failure, Category>?> call(Params params) async{
    return await categoryRepository.addCategory(params.data);
  }

}