import 'package:dartz/dartz.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/entities/product.dart';
import 'package:template/domain/repositories/product_repository.dart';

class AddProductUsecase extends UseCase<Product, Params> {

  final ProductRepository productRepository;

  AddProductUsecase(this.productRepository);

  @override
  Future<Either<Failure, Product>?> call(Params params) async{
    return await productRepository.addProduct(params.data);
  }

}