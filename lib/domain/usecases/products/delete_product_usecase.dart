import 'package:dartz/dartz.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/repositories/product_repository.dart';

class DeleteProductUsecase extends UseCase<bool, Params> {

  final ProductRepository productRepository;

  DeleteProductUsecase(this.productRepository);

  @override
  Future<Either<Failure, bool>?> call(Params params) async{
    return await productRepository.deleteProduct(params.data);
  }

}