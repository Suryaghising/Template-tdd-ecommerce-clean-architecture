import 'package:template/data/models/market_place_profile_request_model.dart';
import 'package:template/domain/entities/market_place_profile.dart';

class MarketPlaceProfileModel extends MarketPlaceProfile {
  const MarketPlaceProfileModel({required super.id, required super.sellerId, required super.name, required super.description, required super.logoUrl});

  factory MarketPlaceProfileModel.fromJson(Map<String, dynamic> json) {
    return MarketPlaceProfileModel(id: json['id'], sellerId: json['seller_id'], name: json['name'], description: json['description'], logoUrl: json['logo_url']);
  }

  static toJson(MarketPlaceProfileModel request) {
    return {
      'id': request.id,
      'seller_id': request.sellerId,
      'name': request.name,
      'description': request.description,
      'logo_url': request.logoUrl
    };
  }

}