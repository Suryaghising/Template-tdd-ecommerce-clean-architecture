import 'package:dartz/dartz.dart';
import 'package:template/data/models/product_request_model.dart';
import 'package:template/domain/entities/product.dart';

import '../../core/error/failures.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, Product>> getProductById(int id);
  Future<Either<Failure, Product>> addProduct(ProductRequestModel request);
  Future<Either<Failure, Product>> updateProduct(Product product);
  Future<Either<Failure, bool>> deleteProduct(int id);
}