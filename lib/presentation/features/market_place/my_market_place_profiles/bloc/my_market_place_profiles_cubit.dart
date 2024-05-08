import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:template/core/error/failures.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/usecases/marketplace/find_my_market_place_profile_usecase.dart';

import '../../../../../domain/entities/market_place_profile.dart';

part 'my_market_place_profiles_state.dart';

class MyMarketPlaceProfileCubit extends Cubit<MyMarketPlaceProfileState> {
  MyMarketPlaceProfileCubit(this.findMyMarketPlaceProfileUsecase)
      : super(MyMarketPlaceProfileInitial());

  final FindMyMarketPlaceProfileUsecase findMyMarketPlaceProfileUsecase;

  getMyMarketPlaceProfiles(int sellerId) async {
    emit(MyMarketPlaceProfileLoading());
    final failureOrMarketPlaceProfiles =
        await findMyMarketPlaceProfileUsecase(Params(data: sellerId));
    failureOrMarketPlaceProfiles!.fold(
        (failure) => emit(MyMarketPlaceProfileFailure(failure)),
        (marketPlaceProfileList) =>
            emit(MyMarketPlaceProfileLoaded(marketPlaceProfileList)));
  }
}
