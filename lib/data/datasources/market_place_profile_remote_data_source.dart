import 'package:template/core/services/dummy_market_place_profile_service.dart';
import 'package:template/data/models/market_place_profile_model.dart';
import 'package:template/data/models/market_place_profile_request_model.dart';
import 'package:template/domain/entities/market_place_profile.dart';

abstract class MarketPlaceProfileRemoteDataSource {
  Future<MarketPlaceProfile> getMyMarketPlaceProfile(int id);
  Future<MarketPlaceProfile> addMyMarketPlaceProfile(MarketPlaceProfileRequestModel request);
  Future<MarketPlaceProfile> updateMarketPlaceProfile(MarketPlaceProfile request);
}

class MarketPlaceProfileRemoteDataSourceImpl implements MarketPlaceProfileRemoteDataSource {

  final DummyMarketPlaceProfileService dummyMarketPlaceProfileService;

  MarketPlaceProfileRemoteDataSourceImpl(this.dummyMarketPlaceProfileService);

  @override
  Future<MarketPlaceProfile> addMyMarketPlaceProfile(MarketPlaceProfileRequestModel request) async{
    final response = dummyMarketPlaceProfileService.addMyMarketPlaceProfile(MarketPlaceProfileRequestModel.toJson(request));
    return MarketPlaceProfileModel.fromJson(response);
  }

  @override
  Future<MarketPlaceProfile> getMyMarketPlaceProfile(int id) async{
    final response = dummyMarketPlaceProfileService.getMyMarketPlaceProfile(id);
    return MarketPlaceProfileModel.fromJson(response);
  }

  @override
  Future<MarketPlaceProfile> updateMarketPlaceProfile(MarketPlaceProfile request) async{
    final marketPlaceProfileModel = MarketPlaceProfileModel(id: request.id, sellerId: request.sellerId, name: request.name, description: request.description, logoUrl: request.logoUrl);
    final response = dummyMarketPlaceProfileService.updateMarketPlaceProfile(MarketPlaceProfileModel.toJson(marketPlaceProfileModel));
    return MarketPlaceProfileModel.fromJson(response);
  }

}