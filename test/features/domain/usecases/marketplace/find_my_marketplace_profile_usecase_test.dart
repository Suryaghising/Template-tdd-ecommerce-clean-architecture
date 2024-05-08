import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/usecases/usecase.dart';
import 'package:template/domain/entities/market_place_profile.dart';
import 'package:template/domain/entities/product.dart';
import 'package:template/domain/repositories/my_market_place_profile_repository.dart';
import 'package:template/domain/repositories/product_repository.dart';
import 'package:template/domain/usecases/marketplace/find_my_market_place_profile_usecase.dart';
import 'package:template/domain/usecases/products/fetch_product_by_id_usecase.dart';

class MockMyMarketPlaceProfileRepository extends Mock implements MyMarketPlaceProfileRepository {}

void main() {

  late FindMyMarketPlaceProfileUsecase findMyMarketPlaceProfileUsecase;
  late MockMyMarketPlaceProfileRepository mockMyMarketPlaceProfileRepository;

  setUpAll(() => {TestWidgetsFlutterBinding.ensureInitialized()});

  setUp(() {
    mockMyMarketPlaceProfileRepository = MockMyMarketPlaceProfileRepository();
    findMyMarketPlaceProfileUsecase = FindMyMarketPlaceProfileUsecase(mockMyMarketPlaceProfileRepository);
  });

  const marketPlaceProfileResponse = MarketPlaceProfile(id: 1, sellerId: 1, name: 'My Marketplace 1', description: 'Test Description', logoUrl: 'Test Logo');

  test('should get myMarketPlaceProfile from mock api request', () async{
    // arrange
    when(() =>mockMyMarketPlaceProfileRepository.getMyMarketPlaceProfile(any()))
        .thenAnswer((_) async => const Right(marketPlaceProfileResponse));
    // act
    final result = await findMyMarketPlaceProfileUsecase(const Params(data: 1));
    //assert
    expect(result, const Right(marketPlaceProfileResponse));
    // verify
    verify(() => mockMyMarketPlaceProfileRepository.getMyMarketPlaceProfile(any())).called(1);
    verifyNoMoreInteractions(mockMyMarketPlaceProfileRepository);
  });
}