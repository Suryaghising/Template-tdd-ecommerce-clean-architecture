import 'package:dartz/dartz.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/entities/market_place_profile.dart';
import 'package:template/domain/repositories/my_market_place_profile_repository.dart';

class UpdateMyMarketPlaceProfileUsecase extends UseCase<MarketPlaceProfile, Params> {

  final MyMarketPlaceProfileRepository myMarketPlaceProfileRepository;

  UpdateMyMarketPlaceProfileUsecase(this.myMarketPlaceProfileRepository);

  @override
  Future<Either<Failure, MarketPlaceProfile>?> call(Params params) async{
    return await myMarketPlaceProfileRepository.updateMarketPlaceProfile(params.data);
  }

}