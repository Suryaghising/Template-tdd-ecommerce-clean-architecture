part of 'update_market_place_profile_cubit.dart';

@immutable
abstract class UpdateMarketPlaceProfileState {}

class UpdateMarketPlaceProfileInitial extends UpdateMarketPlaceProfileState {}

class UpdateMarketPlaceProfileLoading extends UpdateMarketPlaceProfileState {}

class UpdateMarketPlaceProfileFailure extends UpdateMarketPlaceProfileState {
  final Failure failure;

  UpdateMarketPlaceProfileFailure(this.failure);
}

class UpdateMarketPlaceProfileSuccess extends UpdateMarketPlaceProfileState {
  final MarketPlaceProfile marketPlaceProfile;

  UpdateMarketPlaceProfileSuccess(this.marketPlaceProfile);
}