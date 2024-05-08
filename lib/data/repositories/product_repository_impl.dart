import 'package:dartz/dartz.dart';
import 'package:template/core/error/exception.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/data/datasources/product_remote_data_source.dart';
import 'package:template/data/models/product_request_model.dart';
import 'package:template/domain/entities/product.dart';
import 'package:template/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {

  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl(this.productRemoteDataSource);

  @override
  Future<Either<Failure, Product>> addProduct(ProductRequestModel request) async{
    try {
      return Right(await productRemoteDataSource.addProduct(request));
    } on ServerException {
      return const Left(ServerFailure());
    } on DuplicateEntryException {
      return const Left(DuplicateEntryFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProduct(int id) async{
    try {
      return Right(await productRemoteDataSource.deleteProduct(id));
    } on ServerException {
      return const Left(ServerFailure());
    } on NotFoundException {
      return const Left(NotFoundFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async{
    try {
      return Right(await productRemoteDataSource.getAllProducts());
    } on ServerException {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(int id) async{
    try {
      return Right(await productRemoteDataSource.getProductById(id));
    } on ServerException {
      return const Left(ServerFailure());
    } on NotFoundException {
      return const Left(NotFoundFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async{
    try {
      return Right(await productRemoteDataSource.updateProduct(product));
    } on ServerException {
      return const Left(ServerFailure());
    } on NotFoundException {
      return const Left(NotFoundFailure());
    }
  }

}