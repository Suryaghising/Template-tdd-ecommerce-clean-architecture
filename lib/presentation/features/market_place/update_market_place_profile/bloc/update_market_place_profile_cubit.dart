import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:template/domain/entities/market_place_profile.dart';
import 'package:template/domain/usecases/marketplace/update_my_market_place_profile_usecase.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

part 'update_market_place_profile_state.dart';

class UpdateMarketPlaceProfileCubit
    extends Cubit<UpdateMarketPlaceProfileState> {
  UpdateMarketPlaceProfileCubit(this.updateMyMarketPlaceProfileUsecase)
      : super(UpdateMarketPlaceProfileInitial());

  final UpdateMyMarketPlaceProfileUsecase updateMyMarketPlaceProfileUsecase;

  updateMarketPlaceProfile(String name, String sellerId, String description,
      String logoUrl, MarketPlaceProfile marketPlaceProfile) async {
    emit(UpdateMarketPlaceProfileLoading());
    if (name.isEmpty) {
      emit(UpdateMarketPlaceProfileFailure(
          const ValidationFailure('Name is required')));
    } else if (sellerId.isEmpty) {
      emit(UpdateMarketPlaceProfileFailure(
          const ValidationFailure('Seller id is required')));
    } else if (description.isEmpty) {
      emit(UpdateMarketPlaceProfileFailure(
          const ValidationFailure('Description is required')));
    } else if (logoUrl.isEmpty) {
      emit(UpdateMarketPlaceProfileFailure(
          const ValidationFailure('Logo url is required')));
    } else {
      final failureOrAddMarketPlaceProfile =
          await updateMyMarketPlaceProfileUsecase(Params(
              data: MarketPlaceProfile(
                  name: name,
                  sellerId: int.parse(sellerId),
                  description: description,
                  logoUrl: logoUrl,
                  id: marketPlaceProfile.id)));
      failureOrAddMarketPlaceProfile!.fold(
          (failure) => emit(UpdateMarketPlaceProfileFailure(failure)),
          (marketPlaceProfile) =>
              emit(UpdateMarketPlaceProfileSuccess(marketPlaceProfile)));
    }
  }
}
