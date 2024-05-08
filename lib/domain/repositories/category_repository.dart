import 'package:dartz/dartz.dart';
import 'package:template/data/models/category_request_model.dart';
import 'package:template/domain/entities/category.dart';

import '../../core/error/failures.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getAllCategories();
  Future<Either<Failure, Category>> addCategory(CategoryRequestModel request);
  Future<Either<Failure, Category>> getCategoryById(int id);
  Future<Either<Failure, Category>> updateCategory(Category category);
  Future<Either<Failure, bool>> deleteCategory(int id);
}