import 'package:dartz/dartz.dart';
import 'package:template/core/error/exception.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/data/datasources/market_place_profile_remote_data_source.dart';
import 'package:template/data/models/market_place_profile_request_model.dart';
import 'package:template/domain/entities/market_place_profile.dart';
import 'package:template/domain/repositories/my_market_place_profile_repository.dart';

class MyMarketPlaceProfileRepositoryImpl implements MyMarketPlaceProfileRepository {

  final MarketPlaceProfileRemoteDataSource marketPlaceProfileRemoteDataSource;

  MyMarketPlaceProfileRepositoryImpl(this.marketPlaceProfileRemoteDataSource);

  @override
  Future<Either<Failure, MarketPlaceProfile>> addMyMarketPlaceProfile(MarketPlaceProfileRequestModel request) async{
    try {
      return Right(await marketPlaceProfileRemoteDataSource.addMyMarketPlaceProfile(request));
    } on ServerException {
      return const Left(ServerFailure());
    } on DuplicateEntryException {
      return const Left(DuplicateEntryFailure());
    }
  }

  @override
  Future<Either<Failure, MarketPlaceProfile>> getMyMarketPlaceProfile(int id) async{
    try {
      return Right(await marketPlaceProfileRemoteDataSource.getMyMarketPlaceProfile(id));
    } on ServerException {
      return const Left(ServerFailure());
    } on NotFoundException {
      return const Left(NotFoundFailure());
    }
  }

  @override
  Future<Either<Failure, MarketPlaceProfile>> updateMarketPlaceProfile(MarketPlaceProfile marketPlaceProfile) async{
    try {
      return Right(await marketPlaceProfileRemoteDataSource.updateMarketPlaceProfile(marketPlaceProfile));
    } on ServerException {
      return const Left(ServerFailure());
    } on NotFoundException {
      return const Left(NotFoundFailure());
    }
  }

}