import 'package:dartz/dartz.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/entities/category.dart';
import 'package:template/domain/repositories/category_repository.dart';

class FetchCategoryUsecase extends UseCase<List<Category>, NoParams> {

  final CategoryRepository categoryRepository;

  FetchCategoryUsecase(this.categoryRepository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async{
    return await categoryRepository.getAllCategories();
  }



}