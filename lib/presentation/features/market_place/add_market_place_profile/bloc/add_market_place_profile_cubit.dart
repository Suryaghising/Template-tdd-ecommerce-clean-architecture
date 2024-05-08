import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/data/models/market_place_profile_request_model.dart';
import 'package:template/domain/entities/market_place_profile.dart';
import 'package:template/domain/usecases/marketplace/add_my_market_place_profile_usecase.dart';

import '../../../../../core/usecases/usecase.dart';

part 'add_market_place_profile_state.dart';

class AddMarketPlaceProfileCubit extends Cubit<AddMarketPlaceProfileState> {
  AddMarketPlaceProfileCubit(this.addMyMarketPlaceProfileUsecase)
      : super(AddMarketPlaceProfileInitial());

  final AddMyMarketPlaceProfileUsecase addMyMarketPlaceProfileUsecase;

  addMarketPlaceProfile(
      String name, String sellerId, String description, String logoUrl) async {
    emit(AddMarketPlaceProfileLoading());
    if (name.isEmpty) {
      emit(AddMarketPlaceProfileFailure(
          const ValidationFailure('Name is required')));
    } else if (sellerId.isEmpty) {
      emit(AddMarketPlaceProfileFailure(
          const ValidationFailure('Seller id is required')));
    } else if (description.isEmpty) {
      emit(AddMarketPlaceProfileFailure(
          const ValidationFailure('Description is required')));
    } else if (logoUrl.isEmpty) {
      emit(AddMarketPlaceProfileFailure(
          const ValidationFailure('Logo url is required')));
    } else {
      final failureOrAddMarketPlaceProfile =
          await addMyMarketPlaceProfileUsecase(Params(
              data: MarketPlaceProfileRequestModel(
                  name: name,
                  sellerId: int.parse(sellerId),
                  description: description,
                  logoUrl: logoUrl)));
      failureOrAddMarketPlaceProfile!.fold(
          (failure) => emit(AddMarketPlaceProfileFailure(failure)),
          (marketPlaceProfile) =>
              emit(AddMarketPlaceProfileSuccess(marketPlaceProfile)));
    }
  }
}
