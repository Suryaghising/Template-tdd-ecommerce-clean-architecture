part of 'add_market_place_profile_cubit.dart';

@immutable
abstract class AddMarketPlaceProfileState {}

class AddMarketPlaceProfileInitial extends AddMarketPlaceProfileState {}

class AddMarketPlaceProfileLoading extends AddMarketPlaceProfileState {}

class AddMarketPlaceProfileFailure extends AddMarketPlaceProfileState {
  final Failure failure;

  AddMarketPlaceProfileFailure(this.failure);
}

class AddMarketPlaceProfileSuccess extends AddMarketPlaceProfileState {
  final MarketPlaceProfile marketPlaceProfile;

  AddMarketPlaceProfileSuccess(this.marketPlaceProfile);
}