import 'package:dartz/dartz.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/repositories/category_repository.dart';

class DeleteCategoryUsecase extends UseCase<bool, Params> {

  final CategoryRepository categoryRepository;

  DeleteCategoryUsecase(this.categoryRepository);

  @override
  Future<Either<Failure, bool>?> call(Params params) async{
    return await categoryRepository.deleteCategory(params.data);
  }

}