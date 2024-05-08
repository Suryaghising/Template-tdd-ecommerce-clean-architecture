import 'package:dartz/dartz.dart';
import 'package:template/data/models/market_place_profile_request_model.dart';
import 'package:template/domain/entities/market_place_profile.dart';

import '../../core/error/failures.dart';

abstract class MyMarketPlaceProfileRepository {

  Future<Either<Failure, MarketPlaceProfile>> addMyMarketPlaceProfile(MarketPlaceProfileRequestModel request);
  Future<Either<Failure, MarketPlaceProfile>> getMyMarketPlaceProfile(int id);
  Future<Either<Failure, MarketPlaceProfile>> updateMarketPlaceProfile(MarketPlaceProfile marketPlaceProfile);
}