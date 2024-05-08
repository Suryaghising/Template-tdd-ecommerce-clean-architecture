import 'package:dartz/dartz.dart';
import 'package:template/core/error/exception.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/data/datasources/category_remote_data_source.dart';
import 'package:template/data/models/category_request_model.dart';
import 'package:template/domain/entities/category.dart';
import 'package:template/domain/repositories/category_repository.dart';

typedef CategoryOperationChooser = Future<Category> Function();

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRepositoryImpl(this.categoryRemoteDataSource);

  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    try {
      return Right(await categoryRemoteDataSource.getAllCategories());
    } on ServerException {
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, Category>> _operateCategory(
      CategoryOperationChooser performCategoryOperation) async {
    try {
      final category = await performCategoryOperation();
      return Right(category);
    } on ServerException {
      return const Left(ServerFailure());
    } on NotFoundException {
      return const Left(NotFoundFailure());
    } on DuplicateEntryException {
      return const Left(DuplicateEntryFailure());
    }
  }

  @override
  Future<Either<Failure, Category>> addCategory(CategoryRequestModel request) async {
    try {
      final category = await categoryRemoteDataSource.addCategory(request);
      return Right(category);
    } on ServerException {
      return const Left(ServerFailure());
    } on DuplicateEntryException {
      return const Left(DuplicateEntryFailure());
    }
  }

  @override
  Future<Either<Failure, Category>> getCategoryById(int id) async {
    return _operateCategory(() => categoryRemoteDataSource.getCategoryById(id));
  }

  @override
  Future<Either<Failure, Category>> updateCategory(Category category) async {
    return _operateCategory(
        () => categoryRemoteDataSource.updateCategory(category));
  }

  @override
  Future<Either<Failure, bool>> deleteCategory(int id) async {
    try {
      return Right(await categoryRemoteDataSource.deleteCategory(id));
    } on ServerException {
      return const Left(ServerFailure());
    } on NotFoundException {
      return const Left(NotFoundFailure());
    }
  }
}
