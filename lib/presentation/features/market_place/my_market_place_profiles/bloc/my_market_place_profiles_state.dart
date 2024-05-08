part of 'my_market_place_profiles_cubit.dart';

@immutable
abstract class MyMarketPlaceProfileState {}

class MyMarketPlaceProfileInitial extends MyMarketPlaceProfileState {}

class MyMarketPlaceProfileLoading extends MyMarketPlaceProfileState {}

class MyMarketPlaceProfileLoaded extends MyMarketPlaceProfileState {
  final MarketPlaceProfile marketPlaceProfile;

  MyMarketPlaceProfileLoaded(this.marketPlaceProfile);
}

class MyMarketPlaceProfileFailure extends MyMarketPlaceProfileState {
  final Failure failure;

  MyMarketPlaceProfileFailure(this.failure);
}