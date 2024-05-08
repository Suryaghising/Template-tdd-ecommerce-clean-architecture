import 'package:dartz/dartz.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/repositories/product_repository.dart';

import '../../entities/product.dart';

class FetchAllProductsUsecase extends UseCase<List<Product>, NoParams> {

  final ProductRepository productRepository;

  FetchAllProductsUsecase(this.productRepository);

  @override
  Future<Either<Failure, List<Product>>?> call(NoParams params) async{
    return await productRepository.getAllProducts();
  }

}