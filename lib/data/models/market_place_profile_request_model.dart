class MarketPlaceProfileRequestModel {
  final int sellerId;
  final String name;
  final String description;
  final String logoUrl;

  MarketPlaceProfileRequestModel(
      {required this.sellerId,
      required this.name,
      required this.description,
      required this.logoUrl});

  static toJson(MarketPlaceProfileRequestModel marketPlaceProfileRequestModel) {
    return {
      'seller_id': marketPlaceProfileRequestModel.sellerId,
      'name': marketPlaceProfileRequestModel.name,
      'description': marketPlaceProfileRequestModel.description,
      'logo_url': marketPlaceProfileRequestModel.logoUrl
    };
  }
}
